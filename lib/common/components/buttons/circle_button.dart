import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/colors.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;

  const CircleButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Icon(Icons.email),
      ),
    );
  }
}
