import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDDotText extends StatelessWidget {
  final String text;

  const DDDotText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow2010,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Positioned(
            top: s(5),
            child: Icon(
              Icons.lens,
              size: s(4),
            ),
          ),
          Container(
              padding: kInnerRowLeft10,
              child: Text(FlutterI18n.translate(context, text)))
        ],
      ),
    );
  }
}
