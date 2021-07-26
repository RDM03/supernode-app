import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class AppBars {
  static backArrowAppBar(
    BuildContext context, {
    Key key,
    String title: '',
    Function onPress,
    Function onTitlePress,
    Color color,
  }) {
    return AppBar(
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorsTheme.of(context).textPrimaryAndIcons,
        ),
      ),
      centerTitle: true,
      backgroundColor: color ?? ColorsTheme.of(context).primaryBackground,
      elevation: 0,
      title: (onTitlePress == null)
          ? Text(title, style: FontTheme.of(context).big())
          : GestureDetector(
              key: key,
              behavior: HitTestBehavior.opaque,
              onTap: onTitlePress,
              child: Text(title, style: FontTheme.of(context).big())),
    );
  }

  static backArrowSkipAppBar(BuildContext context,
      {Function onPress, String action = "", String title = ''}) {
    return AppBar(
      title: Center(child: Text(title, style: FontTheme.of(context).big())),
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios,
            color: ColorsTheme.of(context).textPrimaryAndIcons),
      ),
      actions: <Widget>[
        FlatButton(
          key: Key('actionKey'),
          onPressed: onPress,
          child: Center(
            child: Text(action, style: FontTheme.of(context).big()),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  static backArrowAndActionAppBar(BuildContext context,
      {String title, Function onPress, Widget action}) {
    return AppBar(
      title: Text(
        title,
        style: FontTheme.of(context).big(),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_back_ios,
            color: ColorsTheme.of(context).textPrimaryAndIcons),
      ),
      actions: <Widget>[if (action != null) action],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
