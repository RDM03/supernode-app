import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

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
              Container(
                child: Text(
                  text,
                  key: key,
                  textAlign: TextAlign.left,
                  style: FontTheme.of(context).middle.secondary(),
                ),
              ),
        ),
        Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)
      ],
    );
  }
}
