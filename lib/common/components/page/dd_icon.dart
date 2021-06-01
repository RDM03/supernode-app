import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/colors.dart';

class DDIcon extends StatelessWidget {
  final Color iconBackgroundColor;
  final String imageUrl;
  final Color imageColor;
  final Color backgroundColor;
  final List<BoxShadow> shadowList;

  const DDIcon(
      {Key key,
      this.iconBackgroundColor,
      this.imageUrl,
      this.imageColor,
      this.backgroundColor = Colors.white,
      this.shadowList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: s(50),
      height: s(50),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: shadowList,
      ),
      child: Image.asset(
        imageUrl,
        color: imageColor,
      ),
    );
  }
}
