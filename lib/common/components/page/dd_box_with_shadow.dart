import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDBoxWithShadow extends StatelessWidget {
  final Widget child;
  final double height;
  final double maxHeight;

  const DDBoxWithShadow({
    Key key,
    @required this.child,
    this.height = 80,
    this.maxHeight = 300
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kRoundRow2005,
      width: double.maxFinite,
      height: s(height),
      constraints: BoxConstraints(
        maxHeight: s(maxHeight)
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(26, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: child
    );
  }

}