import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/profile.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ProfileState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  Widget unbindWeChatConfirmation() {
    return Material(
      color: Colors.white,
      child: Stack(alignment: Alignment.topRight, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            child: Icon(Icons.close, color: Colors.black),
            onTap: () => dispatch(ProfileActionCreator.showConfirmation(false)),
          ),
        ),
        Column(children: [
          Spacer(),
          Image.asset(AppImages.warningRobot),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                FlutterI18n.translate(_ctx, 'confirm_wechat_unbind')
                    .replaceFirst('{0}', state.email),
                style: kMiddleFontOfBlack,
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryButton(
                onTap: () => dispatch(
                    ProfileActionCreator.onUnbind(ExternalUser.weChatService)),
                buttonTitle: FlutterI18n.translate(_ctx, 'unbind_wechat_button')
                    .replaceFirst(
                        '{0}', state.weChatUser?.externalUsername ?? ''),
                minWidget: double.infinity),
          ),
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
            Text(FlutterI18n.translate(_ctx, 'shopify_email_instruction'),
                style: kBigBoldFontOfBlack),
            SizedBox(height: 30),
            TextFieldWithTitle(
              title: FlutterI18n.translate(_ctx, 'email'),
              controller: state.shopifyEmailCtl,
            ),
            Spacer(),
            PrimaryButton(
                buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                onTap: () => dispatch(ProfileActionCreator.onShopifyEmail(
                    state.shopifyEmailCtl.text)),
                minHeight: 45,
                minWidget: double.infinity)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            child: Icon(Icons.close, color: Colors.black),
            onTap: () => dispatch(ProfileActionCreator.bindShopifyStep(0)),
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
            Text(FlutterI18n.translate(_ctx, 'send_email'),
                style: kBigFontOfBlack),
            SizedBox(height: 30),
            PrimaryTextField(controller: state.shopifyVerificationCodeCtl),
            Spacer(),
            PrimaryButton(
                buttonTitle: FlutterI18n.translate(_ctx, 'continue'),
                onTap: () => dispatch(
                    ProfileActionCreator.onShopifyEmailVerification(
                        state.shopifyVerificationCodeCtl.text)),
                minHeight: 45,
                minWidget: double.infinity)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            child: Icon(Icons.close, color: Colors.black),
            onTap: () => dispatch(ProfileActionCreator.bindShopifyStep(0)),
          ),
        ),
      ]),
    );
  }

  return Stack(children: [
    pageFrame(context: viewService.context, children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'profile_setting'),
          onTap: () => Navigator.pop(_ctx)),
      ProfileRow(
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        name: state.username,
        position: state.isAdmin ? FlutterI18n.translate(_ctx, 'admin') : '',
      ),
      Form(
        key: state.formKey,
        child: Column(children: <Widget>[
          TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'username'),
            validator: (value) => _validUsername(_ctx, value),
            controller: state.usernameCtl,
          ),
          smallColumnSpacer(),
          TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'email'),
            validator: (value) => _validEmail(_ctx, value),
            controller: state.emailCtl,
          ),
        ]),
      ),
      submitButton(FlutterI18n.translate(_ctx, 'update'),
          onPressed: () => dispatch(ProfileActionCreator.onUpdate())),
      if (state.weChatUser != null)
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Divider(color: Colors.grey),
            ),
            PrimaryButton(
              // WeChat account
              onTap: () =>
                  dispatch(ProfileActionCreator.showConfirmation(true)),
              buttonTitle: FlutterI18n.translate(_ctx, 'unbind_wechat_button')
                  .replaceFirst('{0}', state.weChatUser?.externalUsername),
              minHeight: 45,
              minWidget: double.infinity,
            ),
          ],
        ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Divider(color: Colors.grey),
      ),
      PrimaryButton(
          // Shopify account
          onTap: () => dispatch((state.shopifyUser == null)
              ? ProfileActionCreator.bindShopifyStep(1)
              : ProfileActionCreator.onUnbind(ExternalUser.shopifyService)),
          buttonTitle: FlutterI18n.translate(
                  _ctx,
                  (state.shopifyUser == null)
                      ? 'bind_shopify_button'
                      : 'unbind_shopify_button')
              .replaceFirst('{0}', state.shopifyUser?.externalUsername ?? ''),
          minHeight: 45,
          minWidget: double.infinity),
    ]),
    Visibility(
      visible: state.showWechatUnbindConfirmation,
      child: unbindWeChatConfirmation(),
    ),
    Visibility(
      visible: state.showWechatUnbindConfirmation,
      child: unbindWeChatConfirmation(),
    ),
    Visibility(
      visible: (state.showBindShopifyStep == 1),
      child: bindShopifyStep1(),
    ),
    Visibility(
      visible: (state.showBindShopifyStep == 2),
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
