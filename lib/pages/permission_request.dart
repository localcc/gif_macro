import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io' show Platform;

class PermissionRequestPage extends StatelessWidget {
  const PermissionRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: MoveWindow(
          child: const Align(
            alignment: AlignmentDirectional.center,
            child: Text("GifMacro"),
          ),
        ),
      ),
      content: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Failed to get hotkeys listening permissions!"),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (Platform.isMacOS)
                  Button(
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Open permissions\nsettings",
                        softWrap: true,
                      ),
                    ),
                    onPressed: () {
                      final parsedUrl = Uri.parse(
                          "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility");
                      launchUrl(parsedUrl);
                    },
                  ),
                if (Platform.isMacOS) const SizedBox(width: 20),
                Button(
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text("Continue without\nhotkeys"),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
