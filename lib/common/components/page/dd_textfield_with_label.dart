import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDTextfieldWithLabel extends StatelessWidget {
  final String label;
  final bool readOnly;
  final String initialValue;
  final TextInputAction textInputAction;
  final String hintText;
  final Function(String) validator;
  final TextEditingController controller;

  const DDTextfieldWithLabel(
      {Key key,
      @required this.label,
      this.readOnly = false,
      this.initialValue,
      this.textInputAction = TextInputAction.next,
      this.hintText,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow2010,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(FlutterI18n.translate(context, label),
              style: FontTheme.of(context).big.primary.bold()),
          TextFormField(
              readOnly: readOnly,
              initialValue: initialValue,
              textInputAction: textInputAction,
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
              )),
        ],
      ),
    );
  }
}
