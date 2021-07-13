import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/page/home_page/wallet/expanded_view.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/theme.dart';

import '../shared.dart';

class WalletTab extends StatefulWidget {
  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) => Scaffold(
        appBar: state.walletSelectedToken == null
            ? homeBar(
                context,
                FlutterI18n.translate(context, 'wallet'),
                onPressed: () => openSettings(context),
              )
            : homeBar(
                context,
                null,
                title: Text(
                  state.walletSelectedToken.ui(context).fullName,
                  style: FontTheme.of(context).big(),
                ),
                onPressed: () => openSettings(context),
              ),
        body: state.walletSelectedToken.ui(context) == null
            ? BlocBuilder<HomeCubit, HomeState>(
                builder: (ctx, state) => PageBody(
                  children: [
                    if (state.displayTokens.contains(Token.mxc))
                      MxcTokenCard(
                        expand: () => context.read<HomeCubit>().changeTab(
                            HomeCubit.WALLET_TAB,
                            walletSelToken: Token.mxc),
                      ),
                    if (state.displayTokens.contains(Token.supernodeDhx))
                      SupernodeDhxTokenCard(
                        expand: () => context.read<HomeCubit>().changeTab(
                            HomeCubit.WALLET_TAB,
                            walletSelToken: Token.supernodeDhx),
                      ),
                    if (state.displayTokens.contains(Token.btc))
                      BtcTokenCard(
                        expand: () => context.read<HomeCubit>().changeTab(
                            HomeCubit.WALLET_TAB,
                            walletSelToken: Token.btc),
                      ),
                    AddNewTokenCard(),
                    SizedBox(height: 15)
                  ],
                ),
              )
            : PageBodySingleChild(
                usePadding: false,
                child: TokenExpandedView(
                  selectedToken: state.walletSelectedToken,
                  onTokenChanged: (t) => context
                      .read<HomeCubit>()
                      .changeTab(HomeCubit.WALLET_TAB, walletSelToken: t),
                ),
              ),
      ),
    );
  }
}
