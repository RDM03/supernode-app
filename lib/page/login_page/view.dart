import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/buttons/supernode_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_list.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: darkBackground,
                  height: s(218),
                  padding: EdgeInsets.only(bottom: s(106)),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(AppImages.splashLogo, height: s(48)),
                ),
                SizedBox(height: s(100)),
                Center(
                  child: Text(
                    FlutterI18n.translate(_ctx, 'choose_supernode'),
                    style: TextStyle(fontSize: s(14), fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(16)),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: state.formKey,
                        autovalidate: false,
                        child: Column(children: <Widget>[
                          Container(
                            margin: kOuterRowTop35,
                            child: TextFieldWithList(
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
                              title: FlutterI18n.translate(_ctx, 'password'),
                              hint: FlutterI18n.translate(_ctx, 'password_hint'),
                              isObscureText: state.isObscureText,
                              validator: (value) => Reg.onValidPassword(_ctx, value),
                              controller: state.passwordCtl,
                              suffixChild: IconButton(icon: Icon(state.isObscureText ? Icons.visibility_off : Icons.visibility), onPressed: () => dispatch(LoginActionCreator.isObscureText())),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: s(12)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          FlutterI18n.translate(_ctx, 'forgot_hint'),
                          style: TextStyle(fontSize: s(12), color: hintFont),
                        ),
                      ),
                      SizedBox(height: s(18)),
                      PrimaryButton(onTap: () => dispatch(LoginActionCreator.onLogin()), buttonTitle: FlutterI18n.translate(_ctx, 'login'), minHeight: s(46)),
                      Container(
                        margin: EdgeInsets.only(top: s(28.5), bottom: s(17.5)),
                        height: s(1),
                        color: darkBackground,
                      ),
                      Text(
                        FlutterI18n.translate(_ctx, 'access_using'),
                        style: TextStyle(fontSize: s(14), color: tipFont),
                      ),
                      SizedBox(height: s(29)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleButton(onTap: () => dispatch(LoginActionCreator.onSignUp())),
                          SizedBox(width: s(30)),
                          CircleButton(onTap: () => dispatch(LoginActionCreator.onSignUp())),
                          SizedBox(width: s(30)),
                          CircleButton(onTap: () => dispatch(LoginActionCreator.onSignUp())),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: s(133),
              child: ClipOval(
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
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: darkBackground,
                        offset: Offset(0, 2),
                        blurRadius: 20,
                        spreadRadius: 10,
                      )
                    ]),
                    child: Icon(Icons.add, size: s(25)),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: true ? s(-304) : 0,
              child: Container(
                color: Colors.white,
                height: ScreenUtil.instance.height,
                width: s(304),
                child: Column(
                  children: Sys.superNodes.keys
                      .map(
                        (node) => Container(
                      child: SupernodeButton(onPress: () => dispatch(LoginActionCreator.selectedSuperNode(node)), selected: state.selectedSuperNode.contains(node), cardChild: Image.asset(AppImages.superNodes[node])),
                    ),
                  )
                      .toList(),
                ),
              ),
            )
          ],
        ),
        onTap: () {
          FocusScope.of(_ctx).requestFocus(FocusNode());
        },
      ));
}

//Container
//(
//margin: kOuterRowTop10,child: Wrap
//(
//children: )
//,
//)
//,
