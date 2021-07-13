import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDNav extends StatelessWidget {
  final String title;
  final bool hasBack;
  final bool hasClose;

  const DDNav(
      {Key key,
      @required this.title,
      this.hasBack = false,
      this.hasClose = false})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      padding: kRoundRow0520,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: Visibility(
                  visible: hasBack,
                  child: GestureDetector(
                      child:
                          Icon(Icons.arrow_back_ios_rounded, color: blackColor),
                      onTap: () => Navigator.of(context).pop()))),
          Spacer(),
          Text(FlutterI18n.translate(context, title),
              style: FontTheme.of(context).big.primary.bold()),
          Spacer(),
          Container(
              width: 100,
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: hasClose,
                child: GestureDetector(
                    child: Padding(
                        padding: kInnerRowRight20,
                        child: Icon(Icons.close, color: blackColor)),
                    onTap: () => Navigator.of(context).pop()),
              ))
        ],
      ),
    );
  }
}
