import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField(
      {@required this.hint,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.done});

  final String hint;
  final bool isObscureText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
      onSubmitted: (_) => textInputAction == TextInputAction.next
          ? FocusScope.of(context).nextFocus()
          : FocusScope.of(context).unfocus(),
      style: kInputTextStyle,
      maxLines: 1,
      obscureText: isObscureText,
      autocorrect: false,
      textInputAction: textInputAction,
    );
  }
}
