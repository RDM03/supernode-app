import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final String label;

  const CircleButton({Key key, this.onTap, this.icon, this.label = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Container(
            width: s(50),
            height: s(50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: darkBackground,
                  offset: Offset(0, 2),
                  blurRadius: 7,
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: icon,
          ),
          (label.isNotEmpty) ? SizedBox(height: s(3)) : SizedBox(),
          (label.isNotEmpty) ? Text(
                                label,
                                style: kSmallBoldFontOfBlack,
                              ) : SizedBox()
        ]));
  }
}
