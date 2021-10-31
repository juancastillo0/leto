import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TextInputParams useTextInput({
  String? text,
  String? Function(String)? validate,
}) {
  final controller = useTextEditingController(text: text);
  final focusNode = useFocusNode();
  final error = useState<String?>(null);
  final isTouched = useState(false);

  final onChangedString = useMemoized(() {
    void _onControllerChange(String newValue) {
      final newError = validate?.call(newValue);
      error.value = newError;
    }

    return _onControllerChange;
  }, [validate]);

  useValueChanged<bool, void>(focusNode.hasPrimaryFocus, (prev, _) {
    if (prev && !focusNode.hasPrimaryFocus) {
      isTouched.value = true;
    }
  });

  return TextInputParams(
    controller: controller,
    focusNode: focusNode,
    error: error.value,
    isTouchedNotifier: isTouched,
    onChangedString: onChangedString,
  );
}

class TextInputParams {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? error;
  bool get isTouched => isTouchedNotifier.value;
  final ValueNotifier<bool> isTouchedNotifier;
  final void Function(String) onChangedString;

  const TextInputParams({
    required this.controller,
    required this.focusNode,
    required this.error,
    required this.isTouchedNotifier,
    required this.onChangedString,
  });

  String? get errorIfTouched => isTouched ? error : null;
  String? get errorIfTouchedNotEmpty =>
      isTouched && controller.text.isNotEmpty ? error : null;
}
