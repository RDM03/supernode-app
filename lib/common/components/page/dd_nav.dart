import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDNav extends StatelessWidget {
  final String title;
  final bool hasBack;
  final bool hasClose;
  final Widget action;
  final Function onActionTap;

  const DDNav(
      {Key key,
      @required this.title,
      this.hasBack = false,
      this.hasClose = false,
      this.action,
      this.onActionTap})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      padding: kRoundRow0520,
      height: 80.h,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (hasBack)
            Container(
                width: 100.w,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: ColorsTheme.of(context).textPrimaryAndIcons,
                        size: 24.w),
                    onTap: () => Navigator.of(context).pop()))
          else
            Container(width: 100.w, alignment: Alignment.centerLeft),
          Spacer(),
          Text(FlutterI18n.translate(context, title),
              style: FontTheme.of(context).big.primary.bold()),
          Spacer(),
          if (hasClose)
            Container(
                width: 100.w,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    child: Padding(
                        padding: kInnerRowRight10,
                        child: Icon(Icons.close,
                            color: ColorsTheme.of(context).textPrimaryAndIcons,
                            size: 24.w)),
                    onTap: () => Navigator.of(context).pop()))
          else
            Container(
                width: 100.w,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    child: Padding(padding: kInnerRowRight10, child: action),
                    onTap: () => onActionTap()))
        ],
      ),
    );
  }
}
