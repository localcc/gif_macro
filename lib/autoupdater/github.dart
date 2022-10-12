import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class GithubAsset {
  const GithubAsset({required this.name, required this.url});

  factory GithubAsset.fromJson(Map<String, dynamic> json) {
    return GithubAsset(name: json['name'], url: json['url']);
  }

  Future<HttpClientResponse> download() async {
    final request = await HttpClient().getUrl(Uri.parse(url));
    request.headers.add("Accept", "application/octet-stream");
    request.headers.add(
        "Authorization", "Bearer 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");

    final response = await request.close();
    return response;
  }

  final String name;
  final String url;
}

class GithubRelease {
  const GithubRelease(
      {required this.tag,
      required this.name,
      required this.body,
      required this.assets});

  factory GithubRelease.fromJson(Map<String, dynamic> json) {
    return GithubRelease(
      tag: json['tag_name'],
      name: json['name'],
      body: json['body'],
      assets: (json['assets'] as List<dynamic>)
          .map((e) => GithubAsset.fromJson(e))
          .toList(),
    );
  }

  final String tag;
  final String name;
  final String body;
  final List<GithubAsset> assets;
}

class GithubRepoSlug {
  const GithubRepoSlug({required this.owner, required this.name});

  final String owner;
  final String name;
}

class GithubApi {
  GithubApi();

  GithubApi withSlug(GithubRepoSlug slug) {
    _repoSlug = slug;
    return this;
  }

  Future<GithubRelease> getLatestRelease() async {
    final url = Uri.parse(
        "https://api.github.com/repos/${_repoSlug!.owner}/${_repoSlug!.name}/releases/latest");

    final headers = {
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer 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"
    };
    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      return GithubRelease.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to get releases!');
    }
  }

  GithubRepoSlug? _repoSlug;
}
