import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/checkbox_with_label.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WechatBindNewAccState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return ScaffoldWidget(
    backgroundColor: cardBackgroundColor,
    padding: kRoundRow2002,
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(FlutterI18n.translate(_ctx, 'wechat_login_title'),
          style: kBigFontOfBlack, textAlign: TextAlign.center),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: Container(
            width: s(171),
            height: s(171),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: s(134),
              height: s(134),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: darkBackground,
                      offset: Offset(0, 2),
                      blurRadius: 20,
                      spreadRadius: 10,
                    )
                  ]),
              child: BlocBuilder<SupernodeCubit, SupernodeState>(
                builder: (context, state) => Container(
                  width: s(134),
                  height: s(134),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: darkBackground,
                          offset: Offset(0, 2),
                          blurRadius: 20,
                          spreadRadius: 10,
                        )
                      ]),
                  child: (state.selectedNode != null)
                      ? CachedNetworkImage(
                          imageUrl: state.selectedNode.logo,
                          placeholder: (a, b) => Image.asset(
                            AppImages.placeholder,
                            width: s(100),
                          ),
                          width: s(100),
                        )
                      : Icon(Icons.add, size: s(25)),
                ),
              ),
            ),
          ),
        ),
        Text(FlutterI18n.translate(_ctx, 'bind_new_account2wechat_title'),
            style: kBigFontOfBlack, textAlign: TextAlign.center),
        Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
                FlutterI18n.translate(_ctx, 'bind_new_account2wechat_desc'),
                style: kMiddleFontOfGrey,
                textAlign: TextAlign.center)),
        Form(
          key: state.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(children: <Widget>[
            Container(
              margin: kOuterRowTop35,
              child: TextFieldWithTitle(
                key: Key('homeEmail'),
                title: FlutterI18n.translate(_ctx, 'email'),
                hint: FlutterI18n.translate(_ctx, 'email_hint'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onValidEmail(_ctx, value),
                controller: state.emailCtl,
              ),
            ),
            Container(
              margin: kOuterRowTop10,
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx, 'organization_name'),
                hint: FlutterI18n.translate(_ctx, 'organization_name_hint'),
                textInputAction: TextInputAction.next,
                validator: (value) => Reg.onNotEmpty(_ctx, value),
                controller: state.orgCtl
                  ..text = state.orgCtl.text == ""
                      ? state.emailCtl.text.split('@')[0]
                      : state.orgCtl.text,
              ),
            ),
            Container(
              margin: kOuterRowTop10,
              child: TextFieldWithTitle(
                title: FlutterI18n.translate(_ctx, 'display_name'),
                hint: FlutterI18n.translate(_ctx, 'display_name_hint'),
                textInputAction: TextInputAction.done,
                validator: (value) => Reg.onNotEmpty(_ctx, value),
                controller: state.displayCtl
                  ..text = state.displayCtl.text == ""
                      ? state.emailCtl.text.split('@')[0]
                      : state.displayCtl.text,
              ),
            ),
          ]),
        ),
        SizedBox(height: 30.0),
        Container(
          padding: kRoundRow2002,
          child: link(
            FlutterI18n.translate(_ctx, 'privacy_policy'),
            onTap: () => Tools.launchURL(Sys.privacyPolicy),
            alignment: Alignment.centerLeft,
          ),
        ),
        CheckboxLabelWidget(
          value: state.isCheckTerms,
          child: link(FlutterI18n.translate(_ctx, 'agree_conditions'),
              onTap: () => Tools.launchURL(Sys.agreePolicy),
              alignment: Alignment.centerLeft),
          onChanged: (_) =>
              dispatch(WechatBindNewAccActionCreator.isCheckTerms()),
        ),
        SizedBox(height: s(18)),
      ],
    ))),
    footer: PrimaryButton(
        key: Key('homeBind'),
        onTap: () => state.isCheckTerms
            ? dispatch(WechatBindNewAccActionCreator.onBindNewAcc())
            : null,
        buttonTitle:
            FlutterI18n.translate(_ctx, 'bind_new_account2wechat_button'),
        minHeight: s(46),
        minWidth: double.infinity),
  );
}
