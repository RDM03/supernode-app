import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/text_field/text_field_with_title.dart';

class SingUpWelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBars.signUpAppBar(onPress: ()=>{}),
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
                "Welcome",
                style: kTitleTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: TextFieldWithTitle(
                title: "Email",
                hint: "Enter your email address",
                textInputAction: TextInputAction.done,
              ),
            ),
            Spacer(),
            Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 46),
                  child: PrimaryButton(
                    onTap: () {
                    },
                    buttonTitle: "Continue",
                  ),
                ),
              ],
            ),
            SizedBox(height: 64)
          ],
        ),

      ),
    );
  }

}