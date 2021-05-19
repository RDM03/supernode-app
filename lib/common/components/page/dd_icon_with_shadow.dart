import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'dd_icon.dart';

class DDIconWithShadow extends StatelessWidget {
  final String imageUrl;

  const DDIconWithShadow({
    Key key,
    this.imageUrl
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDIcon(
      iconBackgroundColor: Colors.white,
      imageUrl: imageUrl,
      imageColor: buttonPrimaryColor,
      shadowList:  [
        BoxShadow(
          color: const Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0, 2),
          blurRadius: 7,
        ),
      ],
    );
  }
}