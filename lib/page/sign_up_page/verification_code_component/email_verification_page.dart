import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/cubit.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/state.dart';
import 'package:supernodeapp/page/sign_up_page/registration_component/registration_page.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../../../route.dart';

class EmailVerificationPage extends StatefulWidget {

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController verificationCodeController = TextEditingController();
  Loading loading;

  @override
  void dispose() {
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cardBackgroundColor,
        appBar: AppBars.backArrowAppBar(
          color: Colors.white,
          title: FlutterI18n.translate(context, 'create_account'),
          onPress: () => Navigator.of(context).pop(),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (a, b) => a.showLoading != b.showLoading,
              listener: (ctx, state) async {
                loading?.hide();
                if (state.showLoading) {
                  loading = Loading.show(ctx);
                }
              },
            ),
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (a, b) => a.signupResult != b.signupResult,
              listener: (ctx, state) async {
                if (state.signupResult == SignupResult.registration)
                  Navigator.of(context).push(route((ctx) => BlocProvider<LoginCubit>.value(
                      value: context.read<LoginCubit>(),
                      child: RegistrationPage())));
              },
            ),
          ],
          child: SafeArea(
              child: Container(
                  padding: kRoundRow2005,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(FlutterI18n.translate(context, 'enail_confirmation'), style: kBigFontOfDarkBlue),
                      Text(FlutterI18n.translate(context, 'send_email'), style: kBigFontOfBlack),
                      SizedBox(height: 30),
                      Form(
                        //TODO key: state.formKey,
                        autovalidate: false,
                        child: TextFieldWithTitle(
                          title: FlutterI18n.translate(context, 'verification_code'),
                          textInputAction: TextInputAction.done,
                          controller: verificationCodeController,
                        ),
                      ),
                      Spacer(),
                      PrimaryButton(
                          onTap: () => context.read<LoginCubit>().verifySignupEmail(verificationCodeController.text.trim()),
                          buttonTitle: FlutterI18n.translate(context, 'confirm'),
                          minHeight: 46),
                    ],
                  ))),
        ));
  }
}