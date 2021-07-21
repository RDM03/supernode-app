import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/cubit.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class WithdrawSecurityCode extends StatefulWidget {
  @override
  _WithdrawSecurityCodeState createState() => _WithdrawSecurityCodeState();
}

class _WithdrawSecurityCodeState extends State<WithdrawSecurityCode> {
  final TextEditingController securityCodeCtrl = TextEditingController();

  @override
  void dispose() {
    securityCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //state.isEnabled = true;
    return pageFrame(context: context, children: [
      pageNavBar(FlutterI18n.translate(context, 'withdraw'),
          onTap: () => Navigator.pop(context),
          leadingWidget: GestureDetector(
              key: ValueKey('navBackButton'),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorsTheme.of(context).textPrimaryAndIcons,
              ),
              onTap: () => context.read<WithdrawCubit>().backToConfirm())),
      xbigColumnSpacer(),
      Center(
        child: Text(
          FlutterI18n.translate(context, 'wthdr_ent_code_01'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      middleColumnSpacer(),
      Center(
        child: Text(
          FlutterI18n.translate(context, 'wthdr_ent_code_02'),
          textAlign: TextAlign.center,
          style: FontTheme.of(context).middle(),
        ),
      ),
      Center(
        child: Text(
          FlutterI18n.translate(context, 'wthdr_ent_code_03'),
          textAlign: TextAlign.center,
          style: FontTheme.of(context).middle(),
        ),
      ),
      xbigColumnSpacer(),
      Form(
        //key: state.formKey,
        autovalidate: false,
        child: TextFieldWithTitle(
          title: FlutterI18n.translate(context, 'wthdr_ent_code_04'),
          textInputAction: TextInputAction.next,
          controller: securityCodeCtrl,
        ),
      ),
      xbigColumnSpacer(),
      BlocBuilder<WithdrawCubit, WithdrawState>(
        buildWhen: (a, b) => a.amount != b.amount,
        builder: (ctx, st) => PrimaryButton(
            onTap: () => Biometrics.authenticate(context,
                    authenticateCallback: () async {
                  context.read<WithdrawCubit>().submit(
                      context.read<SupernodeCubit>().state.orgId,
                      securityCodeCtrl.text.trim());
                }),
            buttonTitle: FlutterI18n.translate(context, 'confirm'),
            minWidth: double.infinity,
            bgColor: st.token.ui(context).color),
      ),
    ]);
  }
}
