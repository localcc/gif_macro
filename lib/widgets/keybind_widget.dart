import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class KeybindWidget extends StatefulWidget {
  const KeybindWidget({required this.onBound, required this.keys, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeybindWidgetState();

  final List<LogicalKeyboardKey>? keys;
  final void Function(List<LogicalKeyboardKey>) onBound;
}

class _KeybindWidgetState extends State<KeybindWidget> {
  @override
  void initState() {
    if (widget.keys != null) {
      _keys = widget.keys!;
    }

    super.initState();
  }

  void _stopListening() {
    FocusScope.of(context).unfocus();
    _isListening = false;
  }

  KeyEventResult _keyHandler(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey.keyId == 0x10000001b) {
        setState(() => _keys = _prevKeys);
        _stopListening();
        return KeyEventResult.handled;
      }

      if (event.logicalKey.keyId == 0x100000008) {
        setState(() => _keys.clear());
        widget.onBound(List.empty());
        _stopListening();
        return KeyEventResult.handled;
      }

      if (!_keys.contains(event.logicalKey)) {
        setState(() => _keys.add(event.logicalKey));
      }
    } else if (event is RawKeyUpEvent) {
      setState(() => _keys.remove(event.logicalKey));
    }
    if (event.logicalKey.keyId < 0x100000000) {
      widget.onBound(_keys);
      _stopListening();
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.keys != null &&
        widget.keys!.isNotEmpty &&
        _keys.isEmpty &&
        !_isListening) {
      _keys = widget.keys!;
    }

    return Button(
      focusNode: _focusNode,
      child: Text(_keys.isEmpty && !_isListening
          ? "Bind"
          : _keys.map((e) => e.keyLabel).join(" + ")),
      onPressed: () {
        _isListening = !_isListening;
        if (_isListening) {
          _prevKeys = List.from(_keys);
          setState(() => _keys.clear());
          _focusNode.requestFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }

  late final FocusNode _focusNode = FocusNode(
      debugLabel: "Listener", onKey: (node, event) => _keyHandler(event));

  List<LogicalKeyboardKey> _keys = List.empty(growable: true);
  List<LogicalKeyboardKey> _prevKeys = List.empty(growable: true);

  bool _isListening = false;
}
