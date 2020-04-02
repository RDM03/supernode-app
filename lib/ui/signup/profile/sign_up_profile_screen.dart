import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/ui/signup/mnemonics/sign_up_mnemonics_route.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/buttons/radio_button_with_text.dart';
import 'package:supernodeapp/widgets/text_field/text_field_with_title.dart';

import '../../../router_service.dart';

class SignUpProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBars.signUpAppBar(onPress: () {
        RouterService.instance.pop(context);
      }),
      body: Container(
        padding: EdgeInsets.all(kBodyMargin),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 110),
                child: TextFieldWithTitle(
                  title: "Email",
                  hint: "Enter your email address",
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFieldWithTitle(
                  title: "Password",
                  hint: "Enter your password",
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFieldWithTitle(
                  title: "Organization Name",
                  hint: "Enter your organization name",
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFieldWithTitle(
                  title: "Display Name",
                  hint: "Enter your display name",
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: RadioButtonWithText(
                    text: "I agree to the MXC terms and conditions"),
              ),
              Container(
                child: RadioButtonWithText(
                    text: "Send me marketing information related to MXC"),
              ),
              SizedBox(height: 50),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, minHeight: 46),
                child: PrimaryButton(
                  onTap: () {
                    RouterService.instance
                        .navigateTo(SignUpMnemonicsRoute.buildPath());
                  },
                  buttonTitle: "Next",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
