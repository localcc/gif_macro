import 'dart:io';

Future<String> processUrl(String url) async {
  if (url.startsWith("https://tenor.com") ||
      url.startsWith("http://tenor.com")) {
    final client = HttpClient();
    var uri = Uri.parse("$url.gif");
    var request = await client.getUrl(uri);
    request.followRedirects = false;
    var response = await request.close();

    var redirectCount = 0;

    while (response.isRedirect) {
      response.drain();
      final location = response.headers.value(HttpHeaders.locationHeader);
      if (location != null) {
        uri = uri.resolve(location);
        request = await client.getUrl(uri);
        request.followRedirects = true;
        response = await request.close();
      }
      redirectCount += 1;
      if (redirectCount >= 100) break;
    }

    return uri.toString();
  }
  return url;
}
