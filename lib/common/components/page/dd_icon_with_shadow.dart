import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'dd_icon.dart';

class DDIconWithShadow extends StatelessWidget {
  final String imageUrl;

  const DDIconWithShadow({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDIcon(
      iconBackgroundColor: ColorsTheme.of(context).textPrimaryAndIcons,
      imageUrl: imageUrl,
      imageColor: ColorsTheme.of(context).mxcBlue,
      shadowList: [
        BoxShadow(
          color: shodowColor,
          offset: Offset(0, 2),
          blurRadius: 7,
        ),
      ],
    );
  }
}
