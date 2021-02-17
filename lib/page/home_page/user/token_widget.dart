import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/home_page/user/tabbed_view.dart';
import 'package:supernodeapp/page/home_page/wallet/btc_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/mxc_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';

class TokenWidget extends StatelessWidget {
  Widget mxc(BuildContext context) => Column(
        children: [
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MxcTokenCardContent(),
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => addTokenDialog(
                  context,
                  displayedTokens:
                      context.read<HomeCubit>().state.displayTokens,
                  parachainConnected:
                      context.read<HomeCubit>().state.parachainUsed,
                  supernodeConnected:
                      context.read<HomeCubit>().state.supernodeUsed,
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: MxcActions(),
          ),
          SizedBox(height: 10),
        ],
      );

  Widget supernodeDhx(BuildContext context) => Column(
        children: [
          SizedBox(height: 16),
          SupernodeDhxTokenCardContent(
            showSimulateMining: false,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SupernodeDhxActions(),
          ),
          SizedBox(height: 10),
        ],
      );

  Widget btc(BuildContext context) => Column(
        children: [
          SizedBox(height: 16),
          BtcTokenCardContent(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: BtcActions(),
          ),
          SizedBox(height: 10),
        ],
      );

  Widget parachainDhx(BuildContext context) => Container(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (a, b) => a.displayTokens != b.displayTokens,
      builder: (ctx, wallet) => TabbedView(
        contentHeight: 300,
        tabs: [
          if (wallet.displayTokens.contains(Token.mxc)) mxc(context),
          if (wallet.displayTokens.contains(Token.supernodeDhx))
            supernodeDhx(context),
          if (wallet.displayTokens.contains(Token.btc)) btc(context),
          if (wallet.displayTokens.contains(Token.parachainDhx))
            parachainDhx(context),
        ],
        tabsColors: [
          if (wallet.displayTokens.contains(Token.mxc)) Token.mxc.color,
          if (wallet.displayTokens.contains(Token.supernodeDhx))
            Token.supernodeDhx.color,
          if (wallet.displayTokens.contains(Token.btc)) Token.btc.color,
          if (wallet.displayTokens.contains(Token.parachainDhx))
            Token.parachainDhx.color,
        ],
      ),
    );
  }
}
