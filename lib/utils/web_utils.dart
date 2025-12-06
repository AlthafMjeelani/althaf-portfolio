import 'package:web/web.dart' as web;

/// Downloads a file on web platform
void downloadFile(String url, String filename) {
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..setAttribute('download', filename);
  anchor.click();
}
