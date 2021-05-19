import 'package:flutter/material.dart';

enum SpacerStyle {small,medium,big,xbig}

class DDBoxSpacer extends StatelessWidget {
  final SpacerStyle height;
  final SpacerStyle width;

  const DDBoxSpacer({
    Key key,
    this.height,
    this.width
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? ((width.index + 1) * 10.0) : 0,
      height: height != null ? ((height.index + 1) * 10.0) : 0,
    );
  }
  
}