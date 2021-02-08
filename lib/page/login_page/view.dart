import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
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
import 'package:supernodeapp/page/login_page/cubit.dart';
import 'package:supernodeapp/page/login_page/state.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: _LoginPageContent(),
      create: (context) => LoginCubit(
        appCubit: context.read<AppCubit>(),
        supernodeCubit: context.read<SupernodeCubit>(),
        dao: context.read<SupernodeRepository>(),
      )..initState(),
    );
  }
}

class _LoginPageContent extends StatefulWidget {
  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Loading loading;

  void clickLogo() {
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
                await Navigator.of(context)
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
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              key: Key('homeLogo'),
                              onTap: clickLogo,
                              child: Container(
                                color: darkBackground,
                                height: s(218),
                                padding: EdgeInsets.only(bottom: s(106)),
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(AppImages.splashLogo,
                                    height: s(48)),
                              ),
                            ),
                            SizedBox(height: s(100)),
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
                                  child: BlocBuilder<LoginCubit, LoginState>(
                                    buildWhen: (a, b) =>
                                        a.selectedSuperNode !=
                                        b.selectedSuperNode,
                                    builder: (context, state) =>
                                        state.selectedSuperNode != null
                                            ? CachedNetworkImage(
                                                imageUrl: state
                                                    .selectedSuperNode.logo,
                                                placeholder: (a, b) =>
                                                    Image.asset(
                                                  AppImages.placeholder,
                                                  width: s(100),
                                                ),
                                                width: s(100),
                                              )
                                            : Icon(
                                                Icons.add,
                                                size: s(25),
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                  margin: kOuterRowTop35,
                                  child: TextFieldWithTitle(
                                    key: Key('homeEmail'),
                                    title:
                                        FlutterI18n.translate(context, 'email'),
                                    hint: FlutterI18n.translate(
                                        context, 'email_hint'),
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
                                      hint: FlutterI18n.translate(
                                          context, 'password_hint'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: onOpenDemo,
                                child: Text(
                                  FlutterI18n.translate(context, 'demo'),
                                  style: TextStyle(
                                      fontSize: s(12), color: hintFont),
                                ),
                              ),
                              GestureDetector(
                                onTap: onForgotPassword,
                                child: Text(
                                  FlutterI18n.translate(context, 'forgot_hint'),
                                  style: TextStyle(
                                      fontSize: s(12), color: hintFont),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: s(18)),
                          PrimaryButton(
                              key: Key('homeLogin'),
                              onTap: onLogin,
                              buttonTitle:
                                  FlutterI18n.translate(context, 'login'),
                              minHeight: s(46),
                              minWidget: double.infinity),
                          Container(
                            margin:
                                EdgeInsets.only(top: s(28.5), bottom: s(17.5)),
                            height: s(1),
                            color: darkBackground,
                          ),
                          Text(
                            FlutterI18n.translate(context, 'access_using'),
                            style: TextStyle(fontSize: s(14), color: tipFont),
                          ),
                          SizedBox(height: s(29)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleButton(
                                onTap: onSignUp,
                                icon: Image.asset(
                                  AppImages.email,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                              SizedBox(width: s(30)),
                              BlocBuilder<LoginCubit, LoginState>(
                                buildWhen: (a, b) =>
                                    a.showWeChatLoginOption !=
                                    b.showWeChatLoginOption,
                                builder: (context, state) => CircleButton(
                                  onTap: state.showWeChatLoginOption
                                      ? onWeChatLogin
                                      : null,
                                  icon: (state.showWeChatLoginOption
                                      ? Image.asset(
                                          AppImages.wechat,
                                          width: 22,
                                          height: 22,
                                        )
                                      : null),
                                ),
                              ),
                              SizedBox(width: s(30)),
                              CircleButton(icon: null),
                            ],
                          ),
                          SizedBox(height: s(20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                          SizedBox(
                            height: s(114),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    FlutterI18n.translate(
                                        context, 'super_node'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                      initiallyExpanded: true,
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
      context: context,
      child: Column(
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
