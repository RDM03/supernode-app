import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/summary_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class TokenHomePageWidget extends StatelessWidget {
  Widget mxc(BuildContext context) =>
      BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => PanelFrame(
                rowTop: EdgeInsets.only(top: 10),
                child: TokenSummaryRow(
                  key: Key('mxcDashboard'),
                  loading: state.balance.loading,
                  image: Token.mxc.ui(context).image,
                  name: Token.mxc.ui(context).name,
                  balance: Tools.priceFormat(state.balance.value),
                  onTap: () => context.read<HomeCubit>().changeTab(
                      HomeCubit.WALLET_TAB,
                      walletSelToken: Token.mxc),
                ),
              ));

  Widget supernodeDhx(BuildContext context) =>
      BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => PanelFrame(
                rowTop: EdgeInsets.only(top: 10),
                child: TokenSummaryRow(
                  key: Key('dhxDashboard'),
                  loading: state.balance.loading,
                  image: Token.supernodeDhx.ui(context).image,
                  name: Token.supernodeDhx.ui(context).name,
                  balance: Tools.priceFormat(state.balance.value),
                  onTap: () => context.read<HomeCubit>().changeTab(
                      HomeCubit.WALLET_TAB,
                      walletSelToken: Token.supernodeDhx),
                ),
              ));

  Widget btc(BuildContext context) =>
      BlocBuilder<SupernodeBtcCubit, SupernodeBtcState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => PanelFrame(
                rowTop: EdgeInsets.only(top: 10),
                child: TokenSummaryRow(
                  key: Key('btcDashboard'),
                  loading: state.balance.loading,
                  image: Token.btc.ui(context).image,
                  name: Token.btc.ui(context).name,
                  balance: Tools.priceFormat(state.balance.value, range: 8),
                  onTap: () => context.read<HomeCubit>().changeTab(
                      HomeCubit.WALLET_TAB,
                      walletSelToken: Token.btc),
                ),
              ));

  Widget parachainDhx(BuildContext context) => Container(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (a, b) => a.displayTokens != b.displayTokens,
      builder: (ctx, wallet) => Column(children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                FlutterI18n.translate(context, "wallet"),
                style: FontTheme.of(context).big.primary.bold(),
              ),
              Spacer(),
              GestureDetector(
                key: Key('addTokenTitle'),
                onTap: () => addTokenDialog(
                  context,
                  cubit: context.read<HomeCubit>(),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: colorSupernodeDhx20,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      '+ ${FlutterI18n.translate(context, 'add_token_title')}',
                      style: MiddleFontOfColor(
                          color: Token.supernodeDhx.ui(context).color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (wallet.displayTokens.contains(Token.mxc)) mxc(context),
        if (wallet.displayTokens.contains(Token.supernodeDhx))
          supernodeDhx(context),
        if (wallet.displayTokens.contains(Token.btc)) btc(context),
        if (wallet.displayTokens.contains(Token.parachainDhx))
          PanelFrame(
              child: parachainDhx(context), rowTop: EdgeInsets.only(top: 10)),
      ]),
    );
  }
}
