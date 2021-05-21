import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/title.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class SendToWalletConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('lockAmountView'),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: pageFrame(
        context: context,
        scrollable: false,
        margin: EdgeInsets.only(top: 40),
        children: [
          PageNavBar(
            text: 'Send to Wallet',
            centerTitle: true,
            textStyle: kBigBoldFontOfBlack,
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 10),
          title(FlutterI18n.translate(context, 'confirmed')),
          done(color: healthColor),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: Text(
              FlutterI18n.translate(context, 'congrats_mining'),
              key: Key('congratsMiningText'),
              style: kPrimaryBigFontOfBlack,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () => Navigator.of(context).pop(),
              minHeight: 46,
              buttonTitle: 'Done',
              bgColor: healthColor,
              minWidth: 0,
              textStyle: kBigFontOfWhite,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
