import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final String label;
  final Color circleColor;

  const CircleButton({
    Key key,
    this.onTap,
    this.icon,
    this.label = "",
    this.circleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor ?? ColorsTheme.of(context).boxComponents,
              boxShadow: [
                BoxShadow(
                  color: ColorsTheme.of(context).primaryBackground,
                  offset: Offset(0, 2),
                  blurRadius: 7,
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: icon,
          ),
          (label.isNotEmpty) ? SizedBox(height: 3.h) : SizedBox(),
          (label.isNotEmpty)
              ? Text(label, style: FontTheme.of(context).middle())
              : SizedBox()
        ]));
  }
}
