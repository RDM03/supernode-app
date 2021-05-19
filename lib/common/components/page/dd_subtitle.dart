import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDSubtitle extends StatelessWidget {
  final String text;

  const DDSubtitle(
    this.text,{
    Key key,
  }): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow2005,
      child: Text(
        FlutterI18n.translate(context, text),
        style: kMiddleFontOfGrey
      )
    );
  }
  
}