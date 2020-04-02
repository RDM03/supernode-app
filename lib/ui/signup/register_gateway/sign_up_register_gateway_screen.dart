import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/router_service.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/buttons/secondary_button.dart';
import 'package:supernodeapp/widgets/text_field/primary_text_field.dart';

import 'item_gateway.dart';

class SignUpRegisterGatewayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                "Register your Gateway",
                style: kTitleTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: kTitleTextStyle4,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: SecondaryButton(
                onTap: () {},
                buttonTitle: "Scan the QR Code",
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "or you can manually input serial number",
                style: kForgotPasswordTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: PrimaryTextField(
                hint: "Gateway Serial Number",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: SecondaryButton(
                onTap: () {},
                buttonTitle: "Add Gateway",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Registered Gateway",
                style: kTitleTextStyle,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: 15,
                itemBuilder: (context, index) => ItemGateway(),
              ),
            ),
            SizedBox(height: 20,),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: PrimaryButton(
                onTap: () {},
                buttonTitle: "Complete",
              ),
            ),
            SizedBox(height: 64)
          ],
        ),
      ),
    );
  }
}
