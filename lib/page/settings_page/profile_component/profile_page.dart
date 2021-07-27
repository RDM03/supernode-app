import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController orgnameController = TextEditingController();
  final TextEditingController orgDisplayController = TextEditingController();
  final TextEditingController shopifyEmailController = TextEditingController();
  final TextEditingController shopifyVerificationCodeControler =
      TextEditingController();

  Loading loading;

  @override
  void initState() {
    super.initState();
    usernameController.text = context.read<SupernodeUserCubit>().state.username;
    emailController.text = context.read<SupernodeUserCubit>().state.email;
    orgnameController.text = context
        .read<SupernodeUserCubit>()
        .state
        .organizations
        .value[0]
        ?.organizationName;
    orgDisplayController.text = context
        .read<SupernodeUserCubit>()
        .state
        .organizations
        .value[0]
        ?.orgDisplayName;
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    orgnameController.dispose();
    orgDisplayController.dispose();
    shopifyEmailController.dispose();
    shopifyVerificationCodeControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget unbindWeChatConfirmation() {
      return Material(
        color: ColorsTheme.of(context).primaryBackground,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            child: GestureDetector(
              child: Icon(Icons.close,
                  color: ColorsTheme.of(context).textPrimaryAndIcons),
              onTap: () => context
                  .read<SettingsCubit>()
                  .showWechatUnbindConfirmation(false),
            ),
          ),
          Column(children: [
            Spacer(),
            Image.asset(AppImages.warningRobot),
            Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                    buildWhen: (a, b) => a.username != b.username,
                    builder: (ctx, s) => Text(
                          FlutterI18n.translate(
                                  context, 'confirm_wechat_unbind')
                              .replaceFirst('{0}', s.username),
                          style: FontTheme.of(context).middle(),
                          textAlign: TextAlign.center,
                        ))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.weChatUser != b.weChatUser,
                  builder: (ctx, s) => PrimaryButton(
                      onTap: () => context
                          .read<SettingsCubit>()
                          .onUnbind(ExternalUser.weChatService),
                      buttonTitle:
                          FlutterI18n.translate(context, 'unbind_wechat_button')
                              .replaceFirst(
                                  '{0}', s.weChatUser?.externalUsername ?? ''),
                      minWidth: double.infinity),
                )),
            Spacer(),
          ])
        ]),
      );
    }

    Widget bindShopifyStep1() {
      return Material(
        color: ColorsTheme.of(context).primaryBackground,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'shopify_email_instruction'),
                  style: FontTheme.of(context).big.primary.bold()),
              SizedBox(height: 30),
              TextFieldWithTitle(
                title: FlutterI18n.translate(context, 'email'),
                controller: shopifyEmailController,
              ),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () => context.read<SettingsCubit>().shopifyEmail(
                      shopifyEmailController.text,
                      FlutterI18n.currentLocale(context).languageCode,
                      FlutterI18n.currentLocale(context).countryCode),
                  minHeight: 45,
                  minWidth: double.infinity)
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            child: GestureDetector(
              child: Icon(Icons.close,
                  color: ColorsTheme.of(context).textPrimaryAndIcons),
              onTap: () => context.read<SettingsCubit>().bindShopifyStep(0),
            ),
          ),
        ]),
      );
    }

    Widget bindShopifyStep2() {
      return Material(
        color: ColorsTheme.of(context).primaryBackground,
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
            child: Column(children: [
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, 'send_email'),
                  style: FontTheme.of(context).big()),
              SizedBox(height: 30),
              PrimaryTextField(controller: shopifyVerificationCodeControler),
              Spacer(),
              PrimaryButton(
                  buttonTitle: FlutterI18n.translate(context, 'continue'),
                  onTap: () => context
                      .read<SettingsCubit>()
                      .shopifyEmailVerification(
                          shopifyVerificationCodeControler.text),
                  minHeight: 45,
                  minWidth: double.infinity)
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            child: GestureDetector(
              child: Icon(Icons.close,
                  color: ColorsTheme.of(context).textPrimaryAndIcons),
              onTap: () => context.read<SettingsCubit>().bindShopifyStep(0),
            ),
          ),
        ]),
      );
    }

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (a, b) => a.showLoading != b.showLoading,
      listener: (ctx, state) async {
        loading?.hide();
        if (state.showLoading) {
          loading = Loading.show(ctx);
        }
      },
      child: Stack(children: [
        pageFrame(context: context, padding: EdgeInsets.all(0.0), children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                PageNavBar(
                  text: FlutterI18n.translate(context, 'super_node'),
                  centerTitle: true,
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(height: 30),
                Center(
                  child: BlocBuilder<SupernodeCubit, SupernodeState>(
                    buildWhen: (a, b) => a.session?.node != b.session?.node,
                    builder: (ctx, state) => CachedNetworkImage(
                      imageUrl: ColorsTheme.of(context).getSupernodeLogo(state.session?.node),
                      placeholder: (a, b) => Image.asset(
                        AppImages.placeholder,
                        height: s(40),
                      ),
                      height: s(40),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 44,
                    color: Colors.black45,
                  ),
                ),
                Center(
                  child: BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                      buildWhen: (a, b) => a.username != b.username,
                      builder: (ctx, s) => Text(
                            s.username,
                            key: Key('usernameText'),
                            style: FontTheme.of(context).big(),
                          )),
                ),
                SizedBox(height: 30),
                Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                    TextFieldWithTitle(
                      key: Key('usernameInput'),
                      title: FlutterI18n.translate(context, 'username'),
                      validator: (value) => _validUsername(context, value),
                      controller: usernameController,
                      textInputAction: TextInputAction.next,
                    ),
                    middleColumnSpacer(),
                    TextFieldWithTitle(
                      key: Key('emailInput'),
                      title: FlutterI18n.translate(context, 'email'),
                      validator: (value) => _validEmail(context, value),
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                    ),
                    middleColumnSpacer(),
                    TextFieldWithTitle(
                      key: Key('organizationNameInput'),
                      title:
                          FlutterI18n.translate(context, 'organization_name'),
                      validator: (value) => _validName(context, value),
                      controller: orgnameController,
                      textInputAction: TextInputAction.next,
                    ),
                    middleColumnSpacer(),
                    TextFieldWithTitle(
                      key: Key('displayNameInput'),
                      title: FlutterI18n.translate(context, 'display_name'),
                      validator: (value) => _validName(context, value),
                      controller: orgDisplayController,
                      textInputAction: TextInputAction.next,
                    ),
                  ]),
                ),
                SizedBox(height: 30),
                PrimaryButton(
                  key: Key('updateButton'),
                  onTap: () {
                    if (!formKey.currentState.validate()) return;
                    context.read<SettingsCubit>().update(
                        usernameController.text.trim(),
                        emailController.text.trim(),
                        orgnameController.text.trim(),
                        orgDisplayController.text.trim());
                  },
                  buttonTitle: FlutterI18n.translate(context, 'update'),
                  minHeight: 45,
                  minWidth: double.infinity,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: ColorsTheme.of(context).primaryBackground,
            width: double.infinity,
            child: Text(
              FlutterI18n.translate(context, 'manage'),
              style: FontTheme.of(context).middle.secondary(),
            ),
          ),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) => a.weChatUser != b.weChatUser,
              builder: (ctx, s) => (s.weChatUser != null)
                  ? Column(
                      children: [
                        listItem(
                            FlutterI18n.translate(
                                    context, 'unbind_wechat_button')
                                .replaceFirst(
                                    '{0}', s.weChatUser?.externalUsername),
                            onTap: () => context
                                .read<SettingsCubit>()
                                .showWechatUnbindConfirmation(true)),
                        Divider(),
                      ],
                    )
                  : SizedBox()),
          BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
              buildWhen: (a, b) => a.shopifyUser != b.shopifyUser,
              builder: (ctx, s) => Column(
                    children: [
                      ListTile(
                        title: Text(
                            FlutterI18n.translate(
                                context, 'bind_shopify_button'),
                            style: FontTheme.of(context).big.secondary()),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: ColorsTheme.of(context).textLabel,
                        ),
                      ),
                      // listItem(
                      //     FlutterI18n.translate(
                      //             context,
                      //             (s.shopifyUser == null)
                      //                 ? 'bind_shopify_button'
                      //                 : 'unbind_shopify_button')
                      //         .replaceFirst(
                      //             '{0}', s.shopifyUser?.externalUsername ?? ''),
                      //     onTap: () => (s.shopifyUser == null)
                      //     ? context.read<SettingsCubit>().bindShopifyStep(1)
                      //     : context
                      //         .read<SettingsCubit>()
                      //         .onUnbind(ExternalUser.shopifyService)),
                      Divider(),
                    ],
                  )),
          listItem(FlutterI18n.translate(context, 'change_password'),
              onTap: () =>
                  Navigator.of(context).pushNamed('change_password_page')),
          Divider(),
          listItem(FlutterI18n.translate(context, 'set_fa_02'),
              onTap: () => Navigator.of(context).pushNamed('set_2fa_page')),
          Divider(),
        ]),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) =>
              a.showWechatUnbindConfirmation != b.showWechatUnbindConfirmation,
          builder: (ctx, s) => Visibility(
            visible: s.showWechatUnbindConfirmation,
            child: unbindWeChatConfirmation(),
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.showBindShopifyStep != b.showBindShopifyStep,
          builder: (ctx, s) => Visibility(
            visible: s.showBindShopifyStep == 1,
            child: bindShopifyStep1(),
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.showBindShopifyStep != b.showBindShopifyStep,
          builder: (ctx, s) => Visibility(
            visible: s.showBindShopifyStep == 2,
            child: bindShopifyStep2(),
          ),
        ),
      ]),
    );
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

  String _validName(BuildContext context, String value) {
    String res = Reg.isEmpty(value);
    if (res != null) {
      return FlutterI18n.translate(context, res);
    }

    return null;
  }
}
