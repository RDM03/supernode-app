import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDTitleWithSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChange;

  const DDTitleWithSwitch(
      {Key key, @required this.title, this.value = true, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kRoundRow2010,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: Text(
              FlutterI18n.translate(context, title),
              style: kBigBoldFontOfBlack,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) => onChange(newValue),
            activeColor: selectedColor,
            inactiveTrackColor: unselectedColor,
          ),
        ]));
  }
}
