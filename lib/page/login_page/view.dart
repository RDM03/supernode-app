import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/buttons/supernode_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_list.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';

Widget buildView(UserState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
//  throw StateError('This is a Dart exception');
  String _currentSugars;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: cardBackgroundColor,
    body: GestureDetector(
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          padding: kRoundRow202,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                AppImages.splashLogo,
                height: 50,
              ),
              Container(
                margin: kOuterRowTop20,
                child: Text(
                  FlutterI18n.translate(_ctx, 'choose_supernode'),
                  style: kMiddleFontOfBlack,
                ),
              ),

              Container(
                  margin: kOuterRowTop10,
                  child: Wrap(
                      children: Sys.superNodes.keys.map((node) => Container(
                        child: SupernodeButton(
                            onPress: () => dispatch(LoginActionCreator.selectedSuperNode(node)),
                            selected: state.selectedSuperNode.contains(node),
                            cardChild: Image.asset(AppImages.superNodes[node])),
                      ),
                      ).toList()
                  )
              ),

              Form(
                key: state.formKey,
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: kOuterRowTop35,
                      child: TextFieldWithList(
                        title: FlutterI18n.translate(_ctx, 'email'),
                        hint: FlutterI18n.translate(_ctx, 'email_hint'),
                        textInputAction: TextInputAction.next,
                        validator: (value) => Reg.onValidEmail(_ctx,value),
                        controller: state.usernameCtl,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextFieldWithTitle(
                        title: FlutterI18n.translate(_ctx, 'password'),
                        hint: FlutterI18n.translate(_ctx, 'password_hint'),
                        isObscureText: state.isObscureText,
                        validator: (value) => Reg.onValidPassword(_ctx,value),
                        controller: state.passwordCtl,
                        suffixChild: IconButton(
                          icon: Icon( state.isObscureText ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => dispatch(LoginActionCreator.isObscureText())
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Spacer(),
              PrimaryButton(
                onTap: () => dispatch(LoginActionCreator.onLogin()),
                buttonTitle: FlutterI18n.translate(_ctx, 'login'),
                minHeight: 46
              ),
              smallColumnSpacer(),
              PrimaryButton(
                onTap: () => dispatch(LoginActionCreator.onSignUp()),
                buttonTitle: FlutterI18n.translate(_ctx, 'sign_up'),
                minHeight: 46
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        FocusScope.of(_ctx).requestFocus(FocusNode());
      },

    )
  );
}