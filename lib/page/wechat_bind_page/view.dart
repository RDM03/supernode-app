import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/components/widgets/component_widgets.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WechatBindState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return ScaffoldWidget(
    backgroundColor: secondaryBackgroundColor,
    padding: kRoundRow2002,
    appBar: AppBar(
      iconTheme: IconThemeData(color: blackColor),
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
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: BlocBuilder<SupernodeCubit, SupernodeState>(
              builder: (context, state) => Container(
                width: s(134),
                height: s(134),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: backgroundColor,
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
        Text(FlutterI18n.translate(_ctx, 'bind_existing_account2wechat_title'),
            style: kBigFontOfBlack, textAlign: TextAlign.center),
        Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
                FlutterI18n.translate(
                    _ctx, 'bind_existing_account2wechat_desc'),
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
                controller: state.usernameCtl,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFieldWithTitle(
                key: Key('homePassword'),
                title: FlutterI18n.translate(_ctx, 'password'),
                hint: FlutterI18n.translate(_ctx, 'password_hint'),
                isObscureText: state.isObscureText,
                validator: (value) => Reg.onValidPassword(_ctx, value),
                controller: state.passwordCtl,
                suffixChild: IconButton(
                    icon: Icon(state.isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        dispatch(WechatBindActionCreator.isObscureText())),
              ),
            ),
          ]),
        ),
      ],
    ))),
    footer: PrimaryButton(
        key: Key('homeBind'),
        onTap: () => dispatch(WechatBindActionCreator.onBind()),
        buttonTitle:
            FlutterI18n.translate(_ctx, 'bind_existing_account2wechat_button'),
        minHeight: s(46),
        minWidth: double.infinity),
  );
}
