import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/theme/font.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget unbindWeChatConfirmation() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () =>
                  context.read<SettingsCubit>()
                      .toBeImplemented(), //dispatch(ProfileActionCreator.showConfirmation(false)),
            ),
          ),
          Column(children: [
            Spacer(),
            Image.asset(AppImages.warningRobot),
            Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                    buildWhen: (a, b) => a.username != b.username,
                    builder: (ctx, s) =>
                        Text(
                          FlutterI18n.translate(context, 'confirm_wechat_unbind').replaceFirst('{0}', s.username),
                          style: kMiddleFontOfBlack,
                          textAlign: TextAlign.center,
                        ))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.weChatUser != b.weChatUser,
                  builder: (ctx, s) =>
                      PrimaryButton(
                          onTap: () => context.read<SettingsCubit>().toBeImplemented(),
                          //dispatch(ProfileActionCreator.onUnbind(ExternalUser.weChatService)),
                          buttonTitle:
                          FlutterI18n.translate(context, 'unbind_wechat_button')
                              .replaceFirst(
                              '{0}', s.weChatUser?.externalUsername ?? ''),
                          minWidget: double.infinity),
                )),
            Spacer(),
          ])
        ]),
      );
    }

    Widget bindShopifyStep1() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'shopify_email_instruction'),
                  style: kBigBoldFontOfBlack),
              SizedBox(height: 30),
              TextFieldWithTitle(
                title: FlutterI18n.translate(context, 'email'),
                //TODO controller: state.shopifyEmailCtl,
              ),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () => context.read<SettingsCubit>().toBeImplemented(),
                  //dispatch(ProfileActionCreator.onShopifyEmail(state.shopifyEmailCtl.text)),
                  minHeight: 45,
                  minWidget: double.infinity)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () =>
                  context.read<SettingsCubit>()
                      .toBeImplemented(), //dispatch(ProfileActionCreator.bindShopifyStep(0)),
            ),
          ),
        ]),
      );
    }

    Widget bindShopifyStep2() {
      return Material(
        color: Colors.white,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'send_email'),
                  style: kBigFontOfBlack),
              SizedBox(height: 30),
              PrimaryTextField(),
              //TODO controller: state.shopifyVerificationCodeCtl),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () => context.read<SettingsCubit>().toBeImplemented(),
                  //dispatch(ProfileActionCreator.onShopifyEmailVerification(state.shopifyVerificationCodeCtl.text)),
                  minHeight: 45,
                  minWidget: double.infinity)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              child: Icon(Icons.close, color: Colors.black),
              onTap: () =>
                  context.read<SettingsCubit>()
                      .toBeImplemented(), //dispatch(ProfileActionCreator.bindShopifyStep(0)),
            ),
          ),
        ]),
      );
    }

    return Stack(children: [
      pageFrame(context: context, children: [
        pageNavBar(FlutterI18n.translate(context, 'profile_setting'),
            onTap: () => Navigator.pop(context)),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.username != b.username,
            builder: (ctx, s) =>
                ProfileRow(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  name: s.username,
                  position:
                  s.isAdmin.value ? FlutterI18n.translate(context, 'admin') : '',
                )),
        Form(
          //TODO key: state.formKey,
          child: Column(children: <Widget>[
            TextFieldWithTitle(
              title: FlutterI18n.translate(context, 'username'),
              validator: (value) => _validUsername(context, value),
              //TODO controller: state.usernameCtl,
            ),
            smallColumnSpacer(),
            TextFieldWithTitle(
              title: FlutterI18n.translate(context, 'email'),
              validator: (value) => _validEmail(context, value),
              //TODO controller: state.emailCtl,
            ),
          ]),
        ),
        submitButton(FlutterI18n.translate(context, 'update'),
            onPressed: () => context.read<SettingsCubit>().toBeImplemented()),
        //dispatch(ProfileActionCreator.onUpdate())),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.weChatUser != b.weChatUser,
            builder: (ctx, s) =>
            (s.weChatUser != null)
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Divider(color: Colors.grey),
                ),
                PrimaryButton(
                  // WeChat account
                  onTap: () =>
                      context.read<SettingsCubit>().toBeImplemented(),
                  //dispatch(ProfileActionCreator.showConfirmation(true)),
                  buttonTitle: FlutterI18n.translate(
                      context, 'unbind_wechat_button')
                      .replaceFirst('{0}', s.weChatUser?.externalUsername),
                  minHeight: 45,
                  minWidget: double.infinity,
                ),
              ],
            )
                : SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Divider(color: Colors.grey),
        ),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
            buildWhen: (a, b) => a.weChatUser != b.weChatUser,
            builder: (ctx, s) =>
                PrimaryButton(
                  // Shopify account
                    onTap: () => context.read<SettingsCubit>().toBeImplemented(),
                    //dispatch((s.shopifyUser == null)
                    //? ProfileActionCreator.bindShopifyStep(1)
                    //: ProfileActionCreator.onUnbind(ExternalUser.shopifyService)),
                    buttonTitle: FlutterI18n.translate(
                        context,
                        (s.shopifyUser == null)
                            ? 'bind_shopify_button'
                            : 'unbind_shopify_button')
                        .replaceFirst(
                        '{0}', s.shopifyUser?.externalUsername ?? ''),
                    minHeight: 45,
                    minWidget: double.infinity)),
      ]),
      Visibility(
        visible: false, //TODO state.showWechatUnbindConfirmation,
        child: unbindWeChatConfirmation(),
      ),
      Visibility(
        visible: false, //TODO (state.showBindShopifyStep == 1),
        child: bindShopifyStep1(),
      ),
      Visibility(
        visible: false, //TODO(state.showBindShopifyStep == 2),
        child: bindShopifyStep2(),
      ),
    ]);
  }

  String _validUsername(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }

  String _validEmail(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) return FlutterI18n.translate(context, res);

    res = Reg.isEmail(value);
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }
}