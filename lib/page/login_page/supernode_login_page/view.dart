import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/expansion_super_node_tile.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/page/home_page/home_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'cubit.dart';
import 'state.dart';

class SupernodeLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SupernodeLoginPageContent();
  }
}

class _SupernodeLoginPageContent extends StatefulWidget {
  @override
  _SupernodeLoginPageContentState createState() =>
      _SupernodeLoginPageContentState();
}

class _SupernodeLoginPageContentState
    extends State<_SupernodeLoginPageContent> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Loading loading;

  void clickTitle() {
    context.read<LoginCubit>().increaseTestCounter();
  }

  void onOpenDemo() {
    context.read<LoginCubit>().demoLogin();
  }

  void onForgotPassword() {
    if (context.read<LoginCubit>().state.selectedSuperNode == null) {
      tip(context, FlutterI18n.translate(context, 'reg_select_supernode'));
      return;
    }
    context.read<LoginCubit>().forgotPassword();
  }

  void onLogin() {
    if (context.read<LoginCubit>().state.selectedSuperNode == null) {
      tip(context, FlutterI18n.translate(context, 'reg_select_supernode'));
      return;
    }
    if (!formKey.currentState.validate()) return;
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    context.read<LoginCubit>().login(username, password);
  }

  Future<void> onWeChatLogin() async {
    if (context.read<LoginCubit>().state.selectedSuperNode == null) {
      tip(context, FlutterI18n.translate(context, 'reg_select_supernode'));
      return;
    }
    context.read<LoginCubit>().weChatLogin();
  }

  void onSignUp() {
    if (context.read<LoginCubit>().state.selectedSuperNode == null) {
      tip(context, FlutterI18n.translate(context, 'reg_select_supernode'));
      return;
    }
    context.read<LoginCubit>().signUp();
  }

  void onSupernodeSelect(Supernode item) {
    context.read<LoginCubit>().setSelectedSuperNode(item);
    context.read<LoginCubit>().setSuperNodeListVisible(false);
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
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
          listenWhen: (a, b) => a.errorMessage != b.errorMessage,
          listener: (ctx, state) async {
            if (state.errorMessage == null) return;
            final message = FlutterI18n.translate(context, state.errorMessage);
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: errorColor,
            ));
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (a, b) => a.result != b.result,
          listener: (ctx, state) async {
            if (state.result == null) return;
            switch (state.result) {
              case LoginResult.home:
                await navigatorKey.currentState
                    .pushAndRemoveUntil(route((c) => HomePage()), (_) => false);
                break;
              case LoginResult.resetPassword:
                await Navigator.of(context).pushNamed("forgot_password_page");
                break;
              case LoginResult.wechat:
                await Navigator.of(context).pushNamed("wechat_login_page");
                break;
              case LoginResult.signUp:
                await Navigator.of(context).pushNamed("sign_up_page");
                break;
            }
            state.copyWith(result: null);
          },
        ),
      ],
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: cardBackgroundColor,
        body: GestureDetector(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          top: s(133),
                          child: GestureDetector(
                            key: Key('homeSupernodeMenu'),
                            onTap: () => context
                                .read<LoginCubit>()
                                .setSuperNodeListVisible(true),
                            child: ClipOval(
                              child: Container(
                                width: s(171),
                                height: s(171),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: darkBackground,
                                  shape: BoxShape.circle,
                                ),
                                child: BlocBuilder<LoginCubit, LoginState>(
                                  buildWhen: (a, b) =>
                                  a.selectedSuperNode !=
                                      b.selectedSuperNode,
                                  builder: (context, state) =>
                                  state.selectedSuperNode != null
                                      ? Container(
                                      width: s(134),
                                      height: s(134),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: darkBackground2,
                                              offset: Offset(0, 2),
                                              blurRadius: 5,
                                              spreadRadius: 5,
                                            )
                                          ]),
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                            .selectedSuperNode.logo,
                                        placeholder: (ctx, url) => Icon(Icons.add, size: s(40)),
                                        width: s(100),
                                      ))
                                      : Image.asset(
                                    AppImages.supernode_placeholder,
                                    width: s(171),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            AppBars.backArrowAppBar(
                              color: Colors.white,
                              title: FlutterI18n.translate(context, 'login'),
                              onPress: () => Navigator.of(context).pop(),
                              onTitlePress: () => clickTitle(),
                            ),
                            SizedBox(height: s(230)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FlutterI18n.translate(
                                      context, 'choose_supernode'),
                                  style: TextStyle(
                                      fontSize: s(14),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () => _showInfoDialog(context),
                                  child: Padding(
                                    key: Key("questionCircle"),
                                    padding: EdgeInsets.all(s(5)),
                                    child: Image.asset(AppImages.questionCircle,
                                        height: s(20)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: s(16)),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: kOuterRowTop20,
                                  child: TextFieldWithTitle(
                                    key: Key('homeEmail'),
                                    title:
                                        FlutterI18n.translate(context, 'email'),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        Reg.onValidEmail(context, value),
                                    controller: usernameController,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: BlocBuilder<LoginCubit, LoginState>(
                                    buildWhen: (a, b) =>
                                        a.obscureText != b.obscureText,
                                    builder: (context, state) =>
                                        TextFieldWithTitle(
                                      key: Key('homePassword'),
                                      title: FlutterI18n.translate(
                                          context, 'password'),
                                      isObscureText: state.obscureText,
                                      validator: (value) =>
                                          Reg.onValidPassword(context, value),
                                      controller: passwordController,
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
                              ],
                            ),
                          ),
                          SizedBox(height: s(12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: onForgotPassword,
                                child: Text(
                                  FlutterI18n.translate(context, 'forgot_hint'),
                                  style: kMiddleFontOfGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: s(18)),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (a, b) =>
                            a.showWeChatLoginOption !=
                                b.showWeChatLoginOption,
                            builder: (context, state) => state.showWeChatLoginOption
                                ? GestureDetector(
                                onTap: onWeChatLogin,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.wechat,
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(height: 70, width: 5),
                                    Text(FlutterI18n.translate(context, 'wechat_login_title'), style: kMiddleFontOfGreyLink,)
                                  ],
                                ))
                                : SizedBox(),
                          ),
                          PrimaryButton(
                              key: Key('homeLogin'),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              onTap: onLogin,
                              buttonTitle:
                                  FlutterI18n.translate(context, 'login'),
                              minHeight: s(46),
                              minWidget: double.infinity),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /* Drawer */
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (a, b) =>
                    a.supernodeListVisible != b.supernodeListVisible,
                builder: (context, state) {
                  if (state.supernodeListVisible)
                    return GestureDetector(
                      onTap: () => context
                          .read<LoginCubit>()
                          .setSuperNodeListVisible(false),
                      child: Container(
                        color: Color(0x33000000),
                      ),
                    );
                  return Container();
                },
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (a, b) =>
                    a.supernodeListVisible != b.supernodeListVisible ||
                    a.showTestNodes != b.showTestNodes ||
                    a.supernodes != b.supernodes,
                builder: (context, state) {
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: state.supernodeListVisible
                        ? 0
                        : -ScreenUtil.instance.width,
                    child: Container(
                      height: ScreenUtil.instance.height,
                      width: s(304),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(s(10)),
                          bottomRight: Radius.circular(s(10)),
                        ),
                      ),
                      child: SingleChildScrollView(
                        key: Key('scrollMenu'),
                        child: Column(children: <Widget>[
                          SizedBox(height: 50),
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  FlutterI18n.translate(
                                      context, 'super_node'),
                                  style: kBigBoldFontOfBlack
                                ),
                              ),
                              Positioned(
                                right: s(15),
                                child: GestureDetector(
                                  onTap: () => context
                                      .read<LoginCubit>()
                                      .setSuperNodeListVisible(false),
                                  child: Icon(Icons.close, size: 24),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              FlutterI18n.translate(context, 'supernode_instructions'),
                              style: kSecondaryButtonOfBlack,
                              textAlign: TextAlign.center,),
                          ),
                          if (!state.supernodes.loading)
                            Column(
                              children: <Widget>[
                                for (var key
                                    in state.supernodes.value?.keys ?? [])
                                  if (key != "Test" || state.showTestNodes)
                                    ExpansionSuperNodesTile(
                                      title: Text(
                                        FlutterI18n.translate(context, key),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      initiallyExpanded: false,
                                      backgroundColor: darkBackground,
                                      children: <Widget>[
                                        for (Supernode item
                                            in state.supernodes.value[key])
                                          GestureDetector(
                                            child: ListTile(
                                              title: Container(
                                                key: Key(item.name),
                                                alignment: Alignment.center,
                                                height: s(65),
                                                child: CachedNetworkImage(
                                                  imageUrl: "${item.logo}",
                                                  placeholder: (a, b) =>
                                                      Image.asset(
                                                    AppImages.placeholder,
                                                    height: s(30),
                                                  ),
                                                  height: s(30),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              onSupernodeSelect(item);
                                            },
                                          ),
                                      ],
                                    ),
                              ],
                            ),
                        ]),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      builder: (context) => Column(
        children: [
          Container(
            width: s(86),
            height: s(86),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: s(67),
              height: s(67),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: darkBackground,
                      offset: Offset(0, 1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ]),
              child: Icon(Icons.add, size: s(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              FlutterI18n.translate(context, 'info_supernode'),
              key: ValueKey("helpText"),
              style: TextStyle(
                color: Colors.black,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
