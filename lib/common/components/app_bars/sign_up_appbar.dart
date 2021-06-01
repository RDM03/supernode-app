import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class AppBars {
  static backArrowAppBar(
      {Key key,
      String title: '',
      Function onPress,
      Function onTitlePress,
      Color color}) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: color ?? backgroundColor,
      elevation: 0,
      title: (onTitlePress == null)
          ? Text(title, style: kBigFontOfBlack)
          : GestureDetector(
              key: key,
              behavior: HitTestBehavior.opaque,
              onTap: onTitlePress,
              child: Text(title, style: kBigFontOfBlack)),
    );
  }

  static backArrowSkipAppBar(
      {Function onPress, String action = "", String title = ''}) {
    return AppBar(
      title: Center(child: Text(title, style: kBigFontOfBlack)),
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      actions: <Widget>[
        FlatButton(
          key: Key('actionKey'),
          onPressed: onPress,
          child: Center(
            child: Text(action, style: kBigFontOfBlack),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  static backArrowAndActionAppBar(
      {String title, Function onPress, Widget action}) {
    return AppBar(
      title: Text(
        title,
        style: kBigFontOfBlack,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      actions: <Widget>[if (action != null) action],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
