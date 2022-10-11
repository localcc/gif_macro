import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tar/tar.dart';

import 'github.dart';

Future<GithubRelease?> getNewerRelease() async {
  try {
    final api = GithubApi().withSlug(
        const GithubRepoSlug(owner: "localcc", name: "autoupdate_test"));
    final release = await api.getLatestRelease();

    final packageInfo = await PackageInfo.fromPlatform();

    final releaseVersion = Version.parse(release.tag);
    final currentVersion = Version.parse(packageInfo.version);

    if (currentVersion >= releaseVersion) {
      return null;
    }

    return release;
  } catch (e) {
    return null;
  }
}

String getExecutablePath() {
  if (Platform.isMacOS) {
    final path = Platform.resolvedExecutable.split(Platform.pathSeparator);
    final app = path.reversed.firstWhere((element) => element.endsWith(".app"));

    final appExecutable =
        path.sublist(0, path.indexOf(app) + 1).join(Platform.pathSeparator);
    return appExecutable;
  } else {
    final splitPath = Platform.resolvedExecutable.split(Platform.pathSeparator);
    return splitPath
        .sublist(0, splitPath.length - 1)
        .join(Platform.pathSeparator);
  }
}

class _Symlink {
  const _Symlink({required this.src, required this.link});
  final String src;
  final String link;
}

Future<bool> downloadUpdate(
    GithubRelease release, Function(double) downloadCallback) async {
  try {
    var platform = "";

    if (Platform.isWindows) {
      platform = "win";
    } else if (Platform.isLinux) {
      platform = "linux";
    } else if (Platform.isMacOS) {
      platform = "macos";
    }

    final asset = release.assets.firstWhere(
        (e) => e.name.contains(platform) && e.name.endsWith("tar.gz"));
    final download = await asset.download();

    final contentLength = download.contentLength;

    var downloaded = 0;

    final tarReader = TarReader(download.map((event) {
      downloaded += event.length;
      downloadCallback(downloaded / contentLength);
      return event;
    }).transform(gzip.decoder));

    final executablePath = getExecutablePath();
    final splitPath = executablePath.split(Platform.pathSeparator);
    final parentPath =
        splitPath.sublist(0, splitPath.length - 1).join(Platform.pathSeparator);

    try {
      await Directory('$executablePath.old').delete(recursive: true);
      // ignore: empty_catches
    } catch (e) {}

    await Directory(executablePath).rename('$executablePath.old');

    final List<_Symlink> symlinks = [];

    while (await tarReader.moveNext()) {
      final entry = tarReader.current;

      var path = '';
      if (Platform.isMacOS) {
        path = '$parentPath${Platform.pathSeparator}${entry.header.name}';
      } else {
        //path = '$parentPath${Platform.pathSeparator}${entry.header.name}';
        final splitName = entry.header.name
            .split(Platform.pathSeparator)
            .sublist(1)
            .join(Platform.pathSeparator);
        if (splitName.isEmpty) continue;
        path = '$executablePath${Platform.pathSeparator}$splitName';
      }

      if (entry.header.typeFlag == TypeFlag.dir) {
        await Directory(path).create(recursive: true);
      } else if (entry.header.typeFlag == TypeFlag.reg) {
        await entry.contents.pipe(File(path).openWrite());
        if (Platform.isLinux || Platform.isMacOS) {
          await Process.run('chmod', ['+x', path]);
        }
      } else if (entry.header.typeFlag == TypeFlag.symlink) {
        symlinks.add(_Symlink(src: path, link: entry.header.linkName!));
      }
    }

    for (final symlink in symlinks) {
      if (Platform.isLinux || Platform.isMacOS) {
        await Process.run('ln', ['-s', symlink.link, symlink.src]);
      }
    }

    return true;
  } catch (e) {
    return false;
  }
}

Future<void> restart() async {
  if (Platform.isMacOS) {
    final appExecutable = getExecutablePath();
    await Process.start(
      'sh',
      [
        '-c',
        'sleep 5 && open $appExecutable',
      ],
      mode: ProcessStartMode.detached,
    );
  } else if (Platform.isLinux) {
    // doing nothing, starting it back always started the app with a blackscreen and no errors/warnings on stdout/stderr.
    // feel free to make a pull request if you figure it out!
  } else {
    await Process.start(
      Platform.resolvedExecutable,
      Platform.executableArguments,
      workingDirectory: Directory.current.path,
      environment: Platform.environment,
      mode: ProcessStartMode.detached,
    );
  }

  exit(0);
}
