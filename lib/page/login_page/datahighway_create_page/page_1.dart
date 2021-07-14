import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'page_2.dart';

class DataHighwayCreatePage extends StatefulWidget {
  @override
  _DataHighwayCreatePageState createState() => _DataHighwayCreatePageState();
}

class _DataHighwayCreatePageState extends State<DataHighwayCreatePage> {
  TextEditingController ethereumController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    ethereumController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget textField(String title, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: title,
          labelText: title,
        ),
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        context,
        color: whiteColor,
        title: 'Create Account',
        onPress: () => Navigator.of(context).pop(),
      ),
      backgroundColor: whiteColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Token.parachainDhx.ui(context).color,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 12),
                  textField('Ethereum Address', ethereumController),
                  SizedBox(height: 8),
                  textField('User Name', userNameController),
                  SizedBox(height: 8),
                  textField('Password', passwordController, obscure: true),
                  SizedBox(height: 8),
                  textField(
                    'Confirm Password',
                    confirmPasswordController,
                    obscure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryButton(
                  bgColor: Token.parachainDhx.ui(context).color,
                  buttonTitle: 'Next',
                  onTap: () => Navigator.of(context)
                      .push(routeWidget(DataHighwayCreate2Page())),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
