import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/dimens.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/widgets/buttons/primary_button.dart';
import 'package:supernodeapp/widgets/buttons/radio_button_with_text.dart';

import '../../../router_service.dart';

class SignUpMnemonicsScreen extends StatelessWidget {
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
                "Your mnemonic phrase",
                style: kTitleTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Write down your mnemonic phrase. This phase can be used to reset your password and two-factor authentication. Keep it safe!\n",
                style: kTitleTextStyle4,
              ),
            ),
            Container(
              height: 350,
              margin: EdgeInsets.only(top: 20),
              child: GridView.count(
                primary: true,
                crossAxisCount: 3,
                childAspectRatio: 3,
                padding: const EdgeInsets.all(0.0),
                children: List.generate(24, (index) {
                  index++;
                  return (Center(
                    child: Text('$index. Phrase', style: kTitleTextStyle1),
                  ));
                }),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: RadioButtonWithText(
                  text: "I wrote it down and put it in a safe."),
            ),
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


