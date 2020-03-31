import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/router_service.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/ui/signup/welcome/sign_up_welcome_route.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/buttons/secondary_button.dart';
import 'package:supernodeapp/widgets/buttons/supernode_button.dart';
import 'package:supernodeapp/widgets/text_field/text_field_with_title.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                "Choose your supernode",
                style: kTitleTextStyle1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SupernodeButton(
                        onPress: () {},
                        colour: Color.fromARGB(255, 255, 255, 255),
                        cardChild: Image.asset("assets/images/huwa.png")),
                  ),
                  Expanded(
                    child: SupernodeButton(
                        onPress: () {},
                        colour: Color.fromARGB(255, 255, 255, 255),
                        cardChild: Image.asset("assets/images/group-2.png")),
                  ),
                  Expanded(
                    child: SupernodeButton(
                        onPress: () {},
                        colour: Color.fromARGB(255, 255, 255, 255),
                        cardChild: Image.asset("assets/images/enlink.png")),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: TextFieldWithTitle(
                title: "Email",
                hint: "Enter your email address",
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextFieldWithTitle(
                title: "Password",
                hint: "Enter your password",
                isObscureText: true,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: GestureDetector(
                    child: Text(
                      "Forgot your password?",
                      style: kForgotPasswordTextStyle,
                    )
                ),
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
                      RouterService.instance.navigateTo(SignUpWelcomeRoute.buildPath());
                    },
                    buttonTitle: "Login",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 46),
                  child: SecondaryButton(
                    onTap: () {},
                    buttonTitle: "Sign up with email",
                  ),
                )
              ],
            ),
            SizedBox(height: 64)
          ],
        ),
      ),
    );
  }
}
