import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/buttons/radio_button_with_text.dart';
import 'package:supernodeapp/widgets/buttons/secondary_button.dart';

import '../../../router_service.dart';

class SignUp2faScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBars.signUpSkipAppBar(onPress: () {
        RouterService.instance.pop(context);
      }),
      body: Container(
        padding: EdgeInsets.all(kBodyMargin),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 110),
              child: Text(
                "Set 2FA",
                style: kTitleTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RadioButtonWithText(
                  text: "Set up two-factor authentication using Google Authenticator."),
            ),
            SizedBox(height: 10,),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: SecondaryButton(
                onTap: () {
                },
                buttonTitle: "Download Google Authenticator",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Write down your mnemonic phrase. This phase can be used to reset your password and two-factor authentication. Keep it safe!\n",
                style: kTitleTextStyle4,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RadioButtonWithText(
                  text: "Login"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RadioButtonWithText(
                  text: "Withdraw"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RadioButtonWithText(
                  text: "Change Password"),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: PrimaryButton(
                onTap: () {

                },
                buttonTitle: "Next",
              ),
            ),
            SizedBox(height: 64)
          ],
        ),
      ),
    );
  }
}


