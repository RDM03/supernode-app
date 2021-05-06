import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      padding: EdgeInsets.zero,
      children: [
        pageNavBar(FlutterI18n.translate(context, 'connect_with_us'),
            padding: const EdgeInsets.all(20),
            onTap: () => Navigator.of(context).pop()),
        Divider(),
        _item(
          name: FlutterI18n.translate(context, 'join_us_telegram'),
          onTap: () => launch('https://t.me/mxcfoundation'),
          leading: FaIcon(
            FontAwesomeIcons.telegramPlane,
            color: buttonPrimaryColor,
            size: 28,
          ),
        ),
        Divider(),
        _item(
          name: FlutterI18n.translate(context, 'join_us_wechat'),
          onTap: () =>
              launch(
                  'https://mp.weixin.qq.com/s/wQI0nGCbzB5089r4_VmzjQ'),
          leading: Image.asset(
            'assets/images/settings/wechat.png',
            color: buttonPrimaryColor,
          ),
        ),
        Divider(),
        _item(
          name: FlutterI18n.translate(context, 'join_us_twitter'),
          onTap: () => launch('https://twitter.com/MXCfoundation'),
          leading: FaIcon(
            FontAwesomeIcons.twitter,
            color: buttonPrimaryColor,
            size: 28,
          ),
        ),
        Divider(),
        _item(
          name: FlutterI18n.translate(context, 'join_us_discord'),
          onTap: () => launch('https://mxc.news/mxcdiscord'),
          leading: FaIcon(
            FontAwesomeIcons.discord,
            color: buttonPrimaryColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}

Widget _item({String name = '', Function onTap, Widget leading}) {
  return ListTile(
    title: Text(name, style: kBigFontOfBlack),
    onTap: onTap,
    leading: leading,
  );
}
