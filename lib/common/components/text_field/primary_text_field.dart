import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart' as c;
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField({
    this.hint,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.textColor,
    this.focusedBorderColor,
    this.controller,
    this.initialValue,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onChanged,
    this.maxLength,
    this.borderColor = c.borderColor,
    this.counterText,
    this.fillColor,
    this.suffixText,
    this.suffixStyle,
    Key key,
  }) : super(key: key);

  final Color borderColor;
  final Color fillColor;
  final Color focusedBorderColor;
  final String hint;
  final bool isObscureText;
  final TextInputAction textInputAction;
  final Function(String) validator;
  final Color textColor;
  final TextEditingController controller;
  final String initialValue;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final int maxLength;
  final String counterText;
  final String suffixText;
  final TextStyle suffixStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      maxLength: maxLength,
      textAlign: textAlign,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        errorMaxLines: 2,
        counterText: counterText,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        focusedBorder: focusedBorderColor != null ? UnderlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor),
        ) : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        fillColor: fillColor,
        filled: fillColor != null,
      ),
      onFieldSubmitted: (_) => textInputAction == TextInputAction.next
          ? FocusScope.of(context).nextFocus()
          : FocusScope.of(context).unfocus(),
      style: MiddleFontOfColor(color: textColor),
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      obscureText: isObscureText,
      autocorrect: false,
      textInputAction: textInputAction,
      initialValue: initialValue,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
