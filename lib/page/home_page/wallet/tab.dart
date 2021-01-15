import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/page/home_page/wallet/expanded_view.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/font.dart';

import '../shared.dart';
import '../bloc/supernode/wallet/cubit.dart';
import '../bloc/supernode/wallet/state.dart';

class WalletTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      buildWhen: (a, b) => a.expanded != b.expanded,
      builder: (ctx, state) => state.expanded
          ? Scaffold(
              appBar: homeBar(
                null,
                title: BlocBuilder<WalletCubit, WalletState>(
                  buildWhen: (a, b) => a.selectedToken != b.selectedToken,
                  builder: (ctx, state) => Text(
                    state.selectedToken.fullName,
                    style: kBigFontOfBlack,
                  ),
                ),
                onPressed: () => openSettings(context),
              ),
              body: PageBodySingleChild(
                usePadding: false,
                child: TokenExpandedView(),
              ),
            )
          : Scaffold(
              appBar: homeBar(
                FlutterI18n.translate(context, 'wallet'),
                onPressed: () => openSettings(context),
              ),
              body: BlocBuilder<WalletCubit, WalletState>(
                builder: (ctx, state) => PageBody(children: [
                  if (state.displayTokens.contains(WalletToken.mxc))
                    MxcTokenCard(isExpanded: false),
                  if (state.displayTokens.contains(WalletToken.supernodeDhx))
                    SupernodeDhxTokenCard(isExpanded: false),
                  AddNewTokenCard(),
                ]),
              ),
            ),
    );
  }
}
