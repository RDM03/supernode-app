import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/theme/font.dart';

class ValueEditor extends StatelessWidget {
  final String textFieldSuffix;
  final TextEditingController controller;
  final num total;
  final String totalSuffix;
  final String title;
  final String subtitle;
  final bool showSlider;
  final bool showTextField;
  final bool showTotal;
  final bool enabled;
  final String hintText;
  final String Function(String) validator;

  const ValueEditor({
    Key key,
    this.textFieldSuffix,
    this.controller,
    this.total,
    this.totalSuffix,
    this.title,
    this.subtitle,
    this.showSlider = true,
    this.showTextField = true,
    this.showTotal = true,
    this.enabled = true,
    this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FlutterI18n.translate(context, title),
                  style: kBigFontOfBlack,
                ),
                if (subtitle != null)
                  Text(
                    FlutterI18n.translate(context, subtitle),
                    style: kSmallFontOfGrey,
                  ),
              ],
            ),
            SizedBox(width: 30),
            if (showTotal)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ColoredText(
                    text: totalSuffix == null
                        ? '${total ?? '??'}'
                        : '${total ?? '??'} $totalSuffix',
                    style: kMiddleFontOfBlack,
                    color: enabled ? null : Color(0xFF98A6AD).withOpacity(0.2),
                  ),
                ),
              ),
          ],
        ),
        if (showSlider) ...[
          SizedBox(height: 10),
          Column(
            children: [
              SizedBox(
                height: 25,
                child: MxcSliderTheme(
                  child: total == null
                      ? Center(
                          child: LinearProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Color(0xFF4665EA)),
                            backgroundColor: Color(0xFF4665EA).withOpacity(0.2),
                          ),
                        )
                      : ValueListenableBuilder<TextEditingValue>(
                          valueListenable: controller,
                          builder: (ctx, val, _) {
                            var parcedVal = double.tryParse(val.text);
                            var percent = 0.0;
                            if (parcedVal != null) {
                              percent = parcedVal / total;
                              if (percent > 1) percent = 1;
                            }
                            if (percent.isNaN) percent = 0;
                            return Slider(
                              key: ValueKey('valueSlider'),
                              value: percent,
                              activeColor: Color(0xFF4665EA),
                              inactiveColor: Color(0xFF4665EA).withOpacity(0.2),
                              onChanged: !enabled
                                  ? null
                                  : (v) {
                                      final balanceVal =
                                          (total * v * 100).floorToDouble() /
                                              100;
                                      controller.text = balanceVal.toString();
                                    },
                            );
                          },
                        ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '0%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '50%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '100%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
        if (showTextField) ...[
          SizedBox(height: 16),
          Container(
            child: PrimaryTextField(
              key: ValueKey('valueTextField'),
              keyboardType: TextInputType.number,
              validator: validator,
              controller: controller,
              suffixText: textFieldSuffix,
              readOnly: !enabled,
              textColor: Color(0xFF98A6AD),
              hint: hintText,
              suffixStyle: enabled ? null : kBigFontOfGrey,
              fillColor: enabled ? null : Color(0xFFEBEFF2),
            ),
          ),
        ]
      ],
    );
  }
}

class ValueEditor2 extends StatelessWidget {
  final String textFieldSuffix;
  final TextEditingController controller;
  final num total;
  final String totalSuffix;
  final String title;
  final String subtitle;
  final bool showSlider;
  final bool showTextField;
  final bool showTotal;
  final bool enabled;
  final String hintText;
  final String Function(String) validator;
  final Color primaryColor;

  const ValueEditor2(
      {Key key,
      this.textFieldSuffix,
      this.controller,
      this.total,
      this.totalSuffix,
      this.title,
      this.subtitle,
      this.showSlider = true,
      this.showTextField = true,
      this.showTotal = true,
      this.enabled = true,
      this.hintText,
      this.validator,
      this.primaryColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FlutterI18n.translate(context, title),
          style: MiddleFontOfColor(color: primaryColor),
        ),
        if (showTextField) ...[
          Container(
            child: PrimaryTextField(
              key: ValueKey('valueTextField'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: validator,
              controller: controller,
              suffixText: textFieldSuffix,
              readOnly: !enabled,
              hint: hintText,
              suffixStyle: enabled ? null : kBigFontOfGrey,
              fillColor: enabled ? null : Color(0xFFEBEFF2),
            ),
          ),
        ],
        SizedBox(height: 16),
        Row(
          children: [
            if (subtitle != null)
              Text(
                FlutterI18n.translate(context, subtitle),
                style: kSmallFontOfGrey,
              ),
            SizedBox(width: 30),
            if (showTotal)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    totalSuffix == null
                        ? '${total ?? '??'}'
                        : '${total ?? '??'} $totalSuffix',
                    style: kMiddleFontOfBlack,
                  ),
                ),
              ),
          ],
        ),
        if (showSlider) ...[
          SizedBox(height: 10),
          Column(
            children: [
              SizedBox(
                height: 25,
                child: MxcSliderTheme(
                  child: total == null
                      ? Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(primaryColor),
                            backgroundColor: primaryColor.withOpacity(0.2),
                          ),
                        )
                      : ValueListenableBuilder<TextEditingValue>(
                          valueListenable: controller,
                          builder: (ctx, val, _) {
                            var parcedVal = double.tryParse(val.text);
                            var percent = 0.0;
                            if (parcedVal != null) {
                              percent = parcedVal / total;
                              if (percent > 1) percent = 1;
                            }
                            if (percent.isNaN) percent = 0;
                            return Slider(
                              key: ValueKey('valueSlider'),
                              value: percent,
                              activeColor: primaryColor,
                              inactiveColor: primaryColor.withOpacity(0.2),
                              onChanged: !enabled
                                  ? null
                                  : (v) {
                                      final balanceVal =
                                          (total * v * 100).floorToDouble() /
                                              100;
                                      controller.text = balanceVal.toString();
                                    },
                            );
                          },
                        ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '0%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '50%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '100%',
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ],
    );
  }
}
