import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/checkbox_with_label.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/cubit.dart';
import 'package:supernodeapp/page/login_page/supernode_login_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController orgDisplayNameController =
      TextEditingController();
  Loading loading;
  bool isCheckTerms = false;
  bool isCheckPrivacy = false;
  bool isCheckSend = false;

  @override
  void initState() {
    emailController.text = context.read<LoginCubit>().state.email;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    orgNameController.dispose();
    orgDisplayNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBars.backArrowAppBar(
        color: Colors.white,
        title: FlutterI18n.translate(context, 'create_account'),
        onPress: () => Navigator.of(context).pop(),
      ),
      padding: kRoundRow2005,
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
              if (state.signupResult == SignupResult.addGateway)
                await openSupernodeMiner(context, hasSkip: true);
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: formKey,
              autovalidate: false,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: kOuterRowTop35,
                    child: TextFieldWithTitle(
                      readOnly: true,
                      title: FlutterI18n.translate(context, 'email'),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Reg.onValidEmail(context, value),
                      controller: emailController,
                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (a, b) => a.obscureText != b.obscureText,
                      builder: (context, state) => TextFieldWithTitle(
                        title: FlutterI18n.translate(context, 'password'),
                        isObscureText: state.obscureText,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            Reg.onValidPassword(context, value),
                        controller: passController,
                        suffixChild: IconButton(
                          icon: Icon(state.obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => context
                              .read<LoginCubit>()
                              .setObscureText(!state.obscureText),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: TextFieldWithTitle(
                      title:
                          FlutterI18n.translate(context, 'organization_name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Reg.onValidOrganizationName(context, value),
                      controller: orgNameController
                        ..text = orgNameController.text == ""
                            ? emailController.text.split('@')[0]
                            : orgNameController.text,
                    ),
                  ),
                  Container(
                    margin: kOuterRowTop10,
                    child: TextFieldWithTitle(
                      title: FlutterI18n.translate(context, 'display_name'),
                      textInputAction: TextInputAction.done,
                      validator: (value) => Reg.onValidOrganizationName(context, value),
                      controller: orgDisplayNameController
                        ..text = orgDisplayNameController.text == ""
                            ? emailController.text.split('@')[0]
                            : orgDisplayNameController.text,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            CheckboxLabelWidget(
              value: isCheckTerms,
              child: link(FlutterI18n.translate(context, 'agree_conditions'),
                  onTap: () => Tools.launchURL(Sys.agreePolicy),
                  alignment: Alignment.centerLeft),
              onChanged: (_) => setState(() {
                isCheckTerms = !isCheckTerms;
              }),
            ),
            CheckboxLabelWidget(
              value: isCheckPrivacy,
              child: link(FlutterI18n.translate(context, 'read_privacy_policy'),
                  onTap: () => Tools.launchURL(Sys.privacyPolicy),
                  alignment: Alignment.centerLeft),
              onChanged: (_) => setState(() {
                isCheckPrivacy = !isCheckPrivacy;
              }),
            ),
            CheckboxLabelWidget(
              value: isCheckSend,
              text: FlutterI18n.translate(context, 'send_marking_information'),
              onChanged: (_) => setState(() {
                isCheckSend = !isCheckSend;
              }),
            ),
          ],
        ),
      ),
      footer: PrimaryButton(
        buttonTitle: FlutterI18n.translate(context, 'next'),
        minHeight: 46,
        onTap: (isCheckTerms && isCheckPrivacy)
            ? () {
                if (!formKey.currentState.validate() ||
                    !isCheckTerms ||
                    !isCheckPrivacy) return;
                String email = emailController.text.trim();
                String password = passController.text.trim();
                String orgName = orgNameController.text.trim();
                String orgDisplayName = orgDisplayNameController.text.trim();
                context
                    .read<LoginCubit>()
                    .registerFinish(email, password, orgName, orgDisplayName);
              }
            : null,
      ),
      backgroundColor: cardBackgroundColor,
    );
  }
}
