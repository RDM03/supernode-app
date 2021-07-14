import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/mining_simulator_page/widgets/value_editor.dart';
import 'package:supernodeapp/theme/font.dart';

class DhxBondingPage extends StatefulWidget {
  @override
  _DhxBondingPageState createState() => _DhxBondingPageState();
}

class _DhxBondingPageState extends State<DhxBondingPage> {
  TextEditingController ctrl = TextEditingController(text: '0');
  Loading loading;

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SupernodeDhxCubit, SupernodeDhxState>(
            listenWhen: (a, b) => a.confirm != b.confirm,
            listener: (ctx, state) async {
              if (state.confirm)
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) => FullScreenDialog(
                    child: IosStyleBottomDialog(
                      //blueActionIndex: 0,
                      list: [
                        IosButtonStyle(
                            title: FlutterI18n.translate(context, 'bond_dhx'),
                            style: kBigFontOfDhxColor),
                        IosButtonStyle(
                            title: FlutterI18n.translate(
                                    context, 'bond_dhx_confirm_info')
                                .replaceFirst('{0}', ctrl.text.trim())),
                        IosButtonStyle(
                            title: FlutterI18n.translate(context, 'proceed'),
                            style: kBigFontOfDhxColor),
                      ],
                      onItemClickListener: (itemIndex) {
                        if (itemIndex == 2)
                          context.read<SupernodeDhxCubit>().bondDhx();
                      },
                    ),
                  ),
                );
            }),
        BlocListener<SupernodeDhxCubit, SupernodeDhxState>(
            listenWhen: (a, b) => a.success != b.success,
            listener: (ctx, state) async {
              if (state.success) {
                await Navigator.pushNamed(context, 'confirm_page', arguments: {
                  'title': FlutterI18n.translate(context, 'bond_dhx'),
                  'content':
                      FlutterI18n.translate(context, 'bond_dhx_successful'),
                  'success': true
                });
                Navigator.of(context).pop(true);
              }
            }),
        BlocListener<SupernodeDhxCubit, SupernodeDhxState>(
          listenWhen: (a, b) => a.showLoading != b.showLoading,
          listener: (ctx, state) async {
            loading?.hide();
            if (state.showLoading) {
              loading = Loading.show(ctx);
            }
          },
        ),
      ],
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: pageFrame(
              context: context,
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                ListTile(
                  title: Center(
                      child: Text(FlutterI18n.translate(context, 'bond_dhx'),
                          style: kBigFontOfBlack)),
                  trailing: GestureDetector(
                      child: Icon(Icons.close, color: Colors.black),
                      onTap: () => Navigator.of(context).pop()),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              width: s(50),
                              height: s(50),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Token.supernodeDhx.color,
                              ),
                              child: Image.asset(
                                AppImages.iconBond,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        FlutterI18n.translate(
                                            context, 'bond_dhx'),
                                        style: kBigBoldFontOfBlack),
                                    RichText(
                                      text: TextSpan(
                                        style: kMiddleFontOfBlack,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: FlutterI18n.translate(
                                                  context,
                                                  'bond_dhx_instruction_1')),
                                          TextSpan(
                                              text: FlutterI18n.translate(
                                                  context, 'click_here'),
                                              style: kMiddleFontOfBlueLink,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    openSupernodeDeposit(
                                                        context,
                                                        Token.supernodeDhx))
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: kMiddleFontOfBlack,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: FlutterI18n.translate(
                                                  context,
                                                  'bond_dhx_instruction_2')),
                                          TextSpan(
                                              text: FlutterI18n.translate(
                                                  context, 'click_here'),
                                              style: kMiddleFontOfBlueLink,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Navigator.pushNamed(
                                                        context, 'lock_page',
                                                        arguments: {
                                                          'isDemo': context
                                                              .read<AppCubit>()
                                                              .state
                                                              .isDemo
                                                        }))
                                        ],
                                      ),
                                    ),
                                  ]),
                            )
                          ]),
                      bigColumnSpacer(),
                      BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                        buildWhen: (a, b) => a.balance != b.balance,
                        builder: (cxt, state) => ValueEditor2(
                          key: ValueKey('amountValueEditor'),
                          controller: ctrl,
                          total:
                              (state.balance.loading) ? 0 : state.balance.value,
                          title: FlutterI18n.translate(context, 'bond_amount'),
                          subtitle:
                              FlutterI18n.translate(context, 'current_balance'),
                          textFieldSuffix: Token.supernodeDhx.name,
                          totalSuffix: Token.supernodeDhx.name,
                          primaryColor: Token.supernodeDhx.color,
                        ),
                      ),
                      bigColumnSpacer(),
                      bigColumnSpacer(),
                      PrimaryButton(
                          key: Key('confirmButton'),
                          minWidth: double.infinity,
                          onTap: () => context
                              .read<SupernodeDhxCubit>()
                              .confirmBondUnbond(bond: ctrl.text.trim()),
                          buttonTitle:
                              FlutterI18n.translate(context, 'confirm'),
                          bgColor: Token.supernodeDhx.color),
                    ],
                  ),
                ),
              ])),
    );
  }
}
