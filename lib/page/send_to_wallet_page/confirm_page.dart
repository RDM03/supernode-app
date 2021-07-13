import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/title.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class SendToWalletConfirmPage extends StatelessWidget {
  final dynamic error;

  const SendToWalletConfirmPage({
    Key key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('confirmGesture'),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: pageFrame(
        context: context,
        scrollable: false,
        margin: EdgeInsets.only(top: 40),
        children: [
          PageNavBar(
            text: FlutterI18n.translate(context, 'send_to_wallet'),
            centerTitle: true,
            textStyle: FontTheme.of(context).big.primary.bold(),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 10),
          title(FlutterI18n.translate(
            context,
            error == null ? 'confirmed' : 'error_tip',
          )),
          done(color: healthColor, success: error == null),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: Text(
              error == null
                  ? FlutterI18n.translate(context, 'send_to_wallet_congrats')
                  : error.toString(),
              key: Key('congratsFuelText'),
              style: FontTheme.of(context).big(),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () => Navigator.of(context).pop(),
              minHeight: 46,
              buttonTitle: FlutterI18n.translate(context, 'done'),
              bgColor: healthColor,
              minWidth: 0,
              style: FontTheme.of(context).big.label(),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
