import 'package:flutter/material.dart';

import 'page/introduction.dart';

class CheckboxLabelWidget extends StatelessWidget {
  const CheckboxLabelWidget({
    this.value,
    this.text,
    this.child,
    this.onChanged,
  });

  final bool value;
  final String text;
  final Widget child;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: child ??
              introduction(text, left: 0, right: 0, top: 0, bottom: 0),
        ),
        Checkbox(value: value, onChanged: onChanged, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)
      ],
    );
  }
}
