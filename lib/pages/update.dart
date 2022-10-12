import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gif_macro/autoupdater/autoupdater.dart';
import 'package:gif_macro/autoupdater/github.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({required this.nextRoute, required this.update, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdatePageState();

  final String nextRoute;
  final GithubRelease update;
}

class _UpdatePageState extends State<UpdatePage> {
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
            const Text(
              'A new update is available!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 650),
              child: Markdown(data: widget.update.body),
            ),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_updating) ...[
                  Button(
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text("Continue without updating"),
                    ),
                    onPressed: () =>
                        Navigator.of(context).popAndPushNamed(widget.nextRoute),
                  ),
                  const SizedBox(width: 50),
                  Button(
                    child: const Padding(
                        padding: EdgeInsets.all(6.0), child: Text("Update")),
                    onPressed: () {
                      setState(() => _updating = true);
                      downloadUpdate(widget.update, (progress) {
                        setState(() => _updateProgress = progress);
                      }).then(
                        (result) {
                          if (result) {
                            restart();
                          } else {
                            Navigator.of(context)
                                .popAndPushNamed(widget.nextRoute);
                          }
                        },
                      );
                    },
                  ),
                ] else ...[
                  ProgressBar(value: _updateProgress * 100)
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _updating = false;
  double _updateProgress = 0.0;
}
