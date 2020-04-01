import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supernodeapp/router_service.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';

class SignUpCodeVerificationScreen extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 110),
              child: Text(
                "We have sent you a verification code to confirm",
                style: kTitleTextStyle,
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 40),
              child: PinCodeTextField(
                textInputType: TextInputType.number,
                autoFocus: true,
                length: 6,
                shape: PinCodeFieldShape.box,
                borderWidth: 1,
                inactiveColor: Color.fromARGB(26, 0, 0, 0),
                activeColor: Color.fromARGB(100, 0, 0, 0),
                selectedColor: Color.fromARGB(100, 0, 0, 0),
                borderRadius: BorderRadius.circular(3),
                onChanged: (String value) {},
              ),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: 46),
              child: PrimaryButton(
                onTap: () {},
                buttonTitle: "Confirm",
              ),
            ),
            SizedBox(height: 64)
          ],
        ),
      ),
    );
  }
}
