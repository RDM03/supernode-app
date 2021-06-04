import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'dd_box_with_shadow.dart';

class DDBoxWithSelect extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const DDBoxWithSelect(
      {Key key, @required this.title, @required this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDBoxWithShadow(
        child: GestureDetector(
            onTap: onTap,
            child: Container(
                alignment: Alignment.center,
                padding: kInnerRowLeft20,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(FlutterI18n.translate(context, title),
                      style: kMiddleBoldFontOfBlack),
                  subtitle: Text(FlutterI18n.translate(context, subtitle),
                      style: kSmallFontOfGrey),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                ))));
  }
}
