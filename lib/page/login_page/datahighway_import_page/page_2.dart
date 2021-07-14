import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

class DataHighwayImport2Page extends StatefulWidget {
  @override
  _DataHighwayImport2PageState createState() => _DataHighwayImport2PageState();
}

class _DataHighwayImport2PageState extends State<DataHighwayImport2Page> {
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
        title: 'Import Account',
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
                  onTap: () {
                    context.read<DataHighwayCubit>().setDataHighwaySession(
                          DataHighwaySession(address: 'mock-account'),
                        );
                    navigatorKey.currentState.pushAndRemoveUntil(
                        routeWidget((c) => HomePage()), (_) => false);
                  },
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
