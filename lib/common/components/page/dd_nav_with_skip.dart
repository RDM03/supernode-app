import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDNavWithSkip extends StatelessWidget {
  final String title;
  final bool hasBack;

  const DDNavWithSkip({
    Key key,
    @required this.title,
    this.hasBack = false,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      padding: kRoundRow0510,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: Visibility(
                  visible: false,
                  child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.black),
                      onTap: () => Navigator.of(context).pop()))),
          Spacer(),
          Text(FlutterI18n.translate(context, title),
              style: kBigBoldFontOfBlack),
          Spacer(),
          Container(
              width: 100,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        FlutterI18n.translate(context, 'skip'),
                        style: kBigFontOfBlack,
                      ),
                    ),
                    onTap: () => navigatorKey.currentState.pushAndRemoveUntil(
                        route((_) => HomePage()), (_) => false),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () => navigatorKey.currentState
                        .pushAndRemoveUntil(
                            route((_) => HomePage()), (_) => false),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
