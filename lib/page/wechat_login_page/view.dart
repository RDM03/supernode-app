import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WechatLoginState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsTheme.of(_ctx).secondaryBackground,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: ColorsTheme.of(_ctx).textPrimaryAndIcons),
        title: Text(FlutterI18n.translate(_ctx, 'wechat_login_title'),
            style: FontTheme.of(_ctx).big(), textAlign: TextAlign.center),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: kRoundRow2002,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      width: s(171),
                      height: s(171),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsTheme.of(_ctx).boxComponents,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: s(134),
                        height: s(134),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorsTheme.of(_ctx).boxComponents,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorsTheme.of(_ctx).primaryBackground,
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
                                color: ColorsTheme.of(_ctx).boxComponents,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsTheme.of(context)
                                        .primaryBackground,
                                    offset: Offset(0, 2),
                                    blurRadius: 20,
                                    spreadRadius: 10,
                                  )
                                ]),
                            child: (state.selectedNode != null)
                                ? CachedNetworkImage(
                                    imageUrl: ColorsTheme.of(context).getSupernodeLogo(state.selectedNode),
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
                  Text(FlutterI18n.translate(_ctx, 'bind_wechat_title'),
                      style: FontTheme.of(_ctx).big(),
                      textAlign: TextAlign.center),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      FlutterI18n.translate(_ctx, 'bind_wechat_desc'),
                      style: FontTheme.of(_ctx).middle.secondary(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  SecondaryButton(
                    onTap: () => dispatch(
                        WechatLoginActionCreator.onAlreadyHaveAccount()),
                    buttonTitle:
                        FlutterI18n.translate(_ctx, 'already_have_account'),
                  ),
                  PrimaryButton(
                    onTap: () =>
                        dispatch(WechatLoginActionCreator.onCreateAccount()),
                    buttonTitle: FlutterI18n.translate(_ctx, 'create_account'),
                  ),
                ],
              ))));
}
