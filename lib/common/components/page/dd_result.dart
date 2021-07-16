import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDResult extends StatelessWidget {
  final String title;
  final String detail;
  final String imageUrl;
  final String buttonText;

  const DDResult(
      {Key key,
      @required this.title,
      @required this.detail,
      @required this.imageUrl,
      this.buttonText = 'done'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: kOuterRowTop50,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      FlutterI18n.translate(context, title),
                      style: FontTheme.of(context).veryBig.primary.bold(),
                    ),
                    DDBoxSpacer(height: SpacerStyle.medium),
                    Image.asset(
                      imageUrl,
                    ),
                    DDBoxSpacer(height: SpacerStyle.medium),
                    Container(
                      padding: kRoundRow2005,
                      child: Text(
                        FlutterI18n.translate(context, detail),
                        textAlign: TextAlign.center,
                        style: FontTheme.of(context).big(),
                      ),
                    ),
                    Spacer(),
                  ],
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: PrimaryButton(
          padding: kRoundRow1005,
          minWidth: double.infinity,
          minHeight: s(40),
          buttonTitle: FlutterI18n.translate(context, buttonText),
          onTap: () => Navigator.of(context).pop(),
        ));
  }
}
