import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

import 'github.dart';

Future<bool> update() async {
  try {
    final api = GithubApi()
        .withSlug(const GithubRepoSlug(owner: "localcc", name: "gif_macro"));
    final release = await api.getLatestRelease();

    final packageInfo = await PackageInfo.fromPlatform();

    final releaseVersion = Version.parse(release.tag);
    final currentVersion = Version.parse(packageInfo.version);

    if (currentVersion <= releaseVersion) {
      return false;
    }

    var platform = "";

    if (Platform.isWindows) {
      platform = "win";
    } else if (Platform.isLinux) {
      platform = "linux";
    } else if (Platform.isMacOS) {
      platform = "macos";
    }

    final asset = release.assets.firstWhere((e) => e.name.contains(platform));
    final download = await asset.download();

    final data = await download.expand((element) => element).toList();

    final archive = ZipDecoder().decodeBytes(data);
    extractArchiveToDisk(archive, './');

    return true;
  } catch (e) {
    return false;
  }
}
