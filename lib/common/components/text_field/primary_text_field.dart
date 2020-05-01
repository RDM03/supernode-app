import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField(
      {@required this.hint,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.done,
      this.validator,
      this.controller,
      this.initialValue,
      this.readOnly = false,
      this.textAlign =  TextAlign.start,
      this.keyboardType,
      this.onChanged,
      this.maxLength,
      this.counterText});

  final String hint;
  final bool isObscureText;
  final TextInputAction textInputAction;
  final Function(String) validator;
  final TextEditingController controller;
  final String initialValue;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final int maxLength;
  final String counterText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textAlign: textAlign,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: kRoundRow105,
        hintText: hint,
        counterText: counterText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
      onFieldSubmitted: (_) => textInputAction == TextInputAction.next
          ? FocusScope.of(context).nextFocus()
          : FocusScope.of(context).unfocus(),
      style: kMiddleFontOfBlack,
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
