import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../shared.dart';

class MxcTokenCard extends StatelessWidget {
  final VoidCallback expand;

  const MxcTokenCard({Key key, this.expand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: expand,
      child: PanelFrame(
        child: MxcTokenCardContent(showArrow: expand != null, showTitle: true),
      ),
    );
  }
}

class MxcTokenCardContent extends StatelessWidget {
  final bool showArrow;
  final bool showTitle;

  const MxcTokenCardContent({
    Key key,
    this.showArrow = false,
    this.showTitle = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (showTitle)
            ? Container(
            width: double.infinity,
            padding: kRoundRow15_5,
            color: Token.mxc.color,
            child: Text('Supernode Server', style: kBigFontOfWhite,))
            : SizedBox(),
        SizedBox(height: 10),
        Container(
          padding: kRoundRow15_5,
          child: Row(
            children: [
              Image.asset(Token.mxc.imagePath),
              SizedBox(width: s(3)),
              Text(Token.mxc.name, style: kBigBoldFontOfBlack),
              Spacer(),
              if (showArrow) Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.balance.loading,
            name: FlutterI18n.translate(context, 'current_balance'),
            value: Tools.priceFormat(state.balance.value),
            token: 'MXC',
          ),
        ),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.stakedAmount != b.stakedAmount,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.stakedAmount.loading,
            name: FlutterI18n.translate(context, 'staked_amount'),
            value: Tools.priceFormat(state.stakedAmount.value),
            token: "MXC",
          ),
        ),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.totalRevenue != b.totalRevenue,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.totalRevenue.loading,
            name: FlutterI18n.translate(context, 'total_revenue'),
            value: Tools.priceFormat(state.totalRevenue.value, range: 2),
            token: "MXC",
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}

class SupernodeDhxTokenCard extends StatelessWidget {
  final VoidCallback expand;

  const SupernodeDhxTokenCard({Key key, this.expand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: expand,
      child: PanelFrame(
        child: SupernodeDhxTokenCardContent(showArrow: expand != null, showTitle: true),
      ),
    );
  }
}

class SupernodeDhxTokenCardContent extends StatelessWidget {
  final bool showArrow;
  final bool showTitle;
  final bool showSimulateMining;

  const SupernodeDhxTokenCardContent({
    Key key,
    this.showArrow = false,
    this.showTitle = false,
    this.showSimulateMining = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (showTitle)
            ? Container(
            width: double.infinity,
            padding: kRoundRow15_5,
            color: Token.supernodeDhx.color,
            child: Text('Supernode Server', style: kBigFontOfWhite,))
            : SizedBox(),
        SizedBox(height: 10),
        Container(
          padding: kRoundRow15_5,
          child: Row(children: [
            Image.asset(Token.supernodeDhx.imagePath),
            SizedBox(width: s(3)),
            Text(Token.supernodeDhx.name, style: kBigBoldFontOfBlack),
            Spacer(),
            if (!showArrow && showSimulateMining)
              PrimaryButton(
                bgColor: Token.supernodeDhx.color,
                buttonTitle: FlutterI18n.translate(context, 'simulate_mining'),
                onTap: () => Navigator.pushNamed(
                  context,
                  'mining_simulator_page',
                  arguments: {
                    'isDemo': context.read<AppCubit>().state.isDemo,
                    'balance':
                        context.read<SupernodeUserCubit>().state.balance.value,
                  },
                ),
              )
            else if (showArrow)
              Icon(Icons.arrow_forward_ios)
          ]),
        ),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.balance.loading,
            name: FlutterI18n.translate(context, 'current_balance'),
            value: Tools.priceFormat(state.balance.value),
            token: 'DHX',
          ),
        ),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          buildWhen: (a, b) => a.lockedAmount != b.lockedAmount,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.lockedAmount.loading,
            name: FlutterI18n.translate(context, 'locked_amount'),
            value: Tools.priceFormat(state.lockedAmount.value),
            token: 'DHX',
          ),
        ),
        TitleDetailRow(
          loading: false,
          name: FlutterI18n.translate(context, 'staked_amount'),
          value: FlutterI18n.translate(context, 'not_available'),
          token: "",
        ),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          buildWhen: (a, b) => a.totalRevenue != b.totalRevenue,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.totalRevenue.loading,
            name: FlutterI18n.translate(context, 'total_revenue'),
            value: Tools.priceFormat(state.totalRevenue.value, range: 2),
            token: 'DHX',
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}

class BtcTokenCard extends StatelessWidget {
  final VoidCallback expand;

  const BtcTokenCard({Key key, this.expand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: expand,
      child: PanelFrame(
        child: BtcTokenCardContent(showArrow: expand != null, showTitle: true),
      ),
    );
  }
}

class BtcTokenCardContent extends StatelessWidget {
  final bool showArrow;
  final bool showTitle;

  const BtcTokenCardContent({
    Key key,
    this.showArrow = false,
    this.showTitle = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (showTitle)
            ? Container(
            width: double.infinity,
            padding: kRoundRow15_5,
            color: Token.btc.color,
            child: Text('Supernode Server', style: kBigFontOfWhite,))
            : SizedBox(),
        SizedBox(height: 10),
        Container(
          padding: kRoundRow15_5,
          child: Row(
            children: [
              Image.asset(Token.btc.imagePath),
              SizedBox(width: s(3)),
              Text(Token.btc.name, style: kBigBoldFontOfBlack),
              Spacer(),
              if (showArrow) Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        BlocBuilder<SupernodeBtcCubit, SupernodeBtcState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => TitleDetailRow(
            loading: state.balance.loading,
            name: FlutterI18n.translate(context, 'current_balance'),
            value: Tools.priceFormat(state.balance.value),
            token: 'BTC',
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}

class AddNewTokenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => addTokenDialog(
        context,
        displayedTokens:
        context.read<HomeCubit>().state.displayTokens,
        parachainConnected:
        context.read<HomeCubit>().state.parachainUsed,
        supernodeConnected:
        context.read<HomeCubit>().state.supernodeUsed,
      ),
      child: PanelFrame(
        child: Padding(
            padding: kRoundRow105,
            child: Column(
              children: [
                Icon(Icons.add_circle, size: 50),
                Text(FlutterI18n.translate(context, 'add_new_token'),
                    style: kMiddleFontOfBlack)
              ],
            )),
      ),
    );
  }
}
