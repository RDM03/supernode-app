import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

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
                  style: FontTheme.of(context).big(),
                ),
                if (subtitle != null)
                  Text(
                    FlutterI18n.translate(context, subtitle),
                    style: FontTheme.of(context).small.secondary(),
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
                    style: FontTheme.of(context).middle(),
                    color: enabled ? null : hintFont20,
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
                                AlwaysStoppedAnimation(colorSupernodeDhx),
                            backgroundColor: colorSupernodeDhx20,
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
                              activeColor: colorSupernodeDhx,
                              inactiveColor: colorSupernodeDhx20,
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
                      style: FontTheme.of(context).small.secondary(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '50%',
                      style: FontTheme.of(context).small.secondary(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '100%',
                      style: FontTheme.of(context).small.secondary(),
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
              textColor: hintFont,
              hint: hintText,
              suffixStyle:
                  enabled ? null : FontTheme.of(context).big.secondary(),
              fillColor:
                  enabled ? null : ColorsTheme.of(context).primaryBackground,
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
      this.primaryColor = blackColor})
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
              keyboardType: TextInputType.number,
              validator: validator,
              controller: controller,
              suffixText: textFieldSuffix,
              readOnly: !enabled,
              hint: hintText,
              suffixStyle:
                  enabled ? null : FontTheme.of(context).big.secondary(),
              fillColor:
                  enabled ? null : ColorsTheme.of(context).primaryBackground,
            ),
          ),
        ],
        SizedBox(height: 16),
        Row(
          children: [
            if (subtitle != null)
              Text(
                FlutterI18n.translate(context, subtitle),
                style: FontTheme.of(context).small.secondary(),
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
                    style: FontTheme.of(context).middle(),
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
                      style: FontTheme.of(context).small.secondary(),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '50%',
                      style: FontTheme.of(context).small.secondary(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '100%',
                      style: FontTheme.of(context).small.secondary(),
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
