import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WechatLoginState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: cardBackgroundColor,
    appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(FlutterI18n.translate(_ctx, 'wechat_login_title'), style: kBigFontOfBlack, textAlign: TextAlign.center),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: SafeArea(
      child: Container(
        padding: kRoundRow202,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: darkBackground,
                      offset: Offset(0, 2),
                      blurRadius: 20,
                      spreadRadius: 10,
                    )
                  ]),
                  child: (GlobalStore.state.superModel.currentNode != null)
                      ? CachedNetworkImage(
                    imageUrl: GlobalStore.state.superModel.currentNode.logo,
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
            Text(FlutterI18n.translate(_ctx, 'bind_wechat_title'), style: kBigFontOfBlack, textAlign: TextAlign.center),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                    FlutterI18n.translate(_ctx, 'bind_wechat_desc'),
                    style: kMiddleFontOfGrey,
                    textAlign: TextAlign.center)
            ),
            Spacer(),
            SecondaryButton(
                onTap: () => dispatch(WechatLoginActionCreator.onAlreadyHaveAccount()),
                buttonTitle: FlutterI18n.translate(_ctx, 'already_have_account'),
            ),
            PrimaryButton(
                onTap: () => dispatch(WechatLoginActionCreator.onCreateAccount()),
                buttonTitle: FlutterI18n.translate(_ctx, 'create_account'),
            ),
          ],
        )
      )
    )
  );
}
