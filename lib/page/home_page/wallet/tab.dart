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
import 'package:supernodeapp/theme/font.dart';

import '../shared.dart';

class WalletTab extends StatefulWidget {
  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  Token selectedToken;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState> (
      listenWhen: (a, b) => a.walletTabClicked != b.walletTabClicked,// Wallet tab
      listener: (context, state) => setState(() => selectedToken = null),
      child: Scaffold(
        appBar: selectedToken == null
            ? homeBar(
                FlutterI18n.translate(context, 'wallet'),
                onPressed: () => openSettings(context),
              )
            : homeBar(
                null,
                title: Text(
                  selectedToken.fullName,
                  style: kBigFontOfBlack,
                ),
                onPressed: () => openSettings(context),
              ),
        body: selectedToken == null
            ? BlocBuilder<HomeCubit, HomeState>(
                builder: (ctx, state) => PageBody(
                  children: [
                    if (state.displayTokens.contains(Token.mxc))
                      MxcTokenCard(
                        expand: () => setState(() => selectedToken = Token.mxc),
                      ),
                    if (state.displayTokens.contains(Token.supernodeDhx))
                      SupernodeDhxTokenCard(
                        expand: () =>
                            setState(() => selectedToken = Token.supernodeDhx),
                      ),
                    if (state.displayTokens.contains(Token.btc))
                      BtcTokenCard(
                        expand: () => setState(() => selectedToken = Token.btc),
                      ),
                    AddNewTokenCard(),
                  ],
                ),
              )
            : PageBodySingleChild(
                usePadding: false,
                child: TokenExpandedView(
                  selectedToken: selectedToken,
                  onTokenChanged: (t) => setState(() => selectedToken = t),
                ),
              ),
      ),
    );
  }
}
