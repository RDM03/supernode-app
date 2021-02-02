import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/wallet/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/wallet/state.dart';
import 'package:supernodeapp/page/home_page/wallet/btc_token/page_content.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'mxc_token/page_content.dart';
import 'supernode_dhx_token/page_content.dart';

class TokenExpandedView extends StatefulWidget {
  @override
  _TokenExpandedViewState createState() => _TokenExpandedViewState();
}

class _TokenExpandedViewState extends State<TokenExpandedView> {
  Widget pageviewIndicator(bool isActive, Token token) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: isActive ? 20 : 19,
      decoration: BoxDecoration(
        color: isActive ? token.color : Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
    );
  }

  PageController controller;
  @override
  void initState() {
    controller = PageController(
      initialPage: context
          .read<WalletCubit>()
          .state
          .displayTokens
          .indexOf(context.read<WalletCubit>().state.selectedToken),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        BlocBuilder<WalletCubit, WalletState>(
          buildWhen: (a, b) => a.displayTokens != b.displayTokens,
          builder: (ctx, state) => PageView.builder(
            itemCount: state.displayTokens.length,
            controller: controller,
            itemBuilder: (ctx, i) {
              if (state.displayTokens[i] == Token.mxc)
                return MxcTokenPageContent(
                  key: ValueKey('mxcPage'),
                );

              if (state.displayTokens[i] == Token.supernodeDhx)
                return SupernodeDhxTokenPageContent(
                  key: ValueKey('supernodeDhxPage'),
                );

              if (state.displayTokens[i] == Token.btc)
                return BtcTokenPageContent(
                  key: ValueKey('btcPage'),
                );

              return Container();
            },
            onPageChanged: (i) {
              context.read<WalletCubit>().expandTo(
                    state.displayTokens[i],
                  );
            },
          ),
        ),
        BlocBuilder<WalletCubit, WalletState>(
          buildWhen: (a, b) =>
              a.displayTokens != b.displayTokens ||
              a.selectedToken != b.selectedToken,
          builder: (ctx, state) {
            if (state.displayTokens.length == 0) return Container();
            return Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: shodowColor,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < state.displayTokens.length; i++)
                          if (state.displayTokens[i] == state.selectedToken)
                            pageviewIndicator(true, state.displayTokens[i])
                          else
                            pageviewIndicator(
                              false,
                              state.displayTokens[i],
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
