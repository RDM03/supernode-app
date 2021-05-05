import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/page/home_page/shared.dart';

import 'dhx_bonding_page.dart';
import 'dhx_unbonding_page.dart';
import 'dhx_mining_page.dart';

class SupernodeDhxActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton(
          icon: Icon(
            Icons.add,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'deposit'),
          onTap: () => openSupernodeDeposit(context, Token.supernodeDhx),
        ),
        Spacer(),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
            buildWhen: (a, b) => a.balance != b.balance,
            builder: (ctx, state) => CircleButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Token.supernodeDhx.color,
                  ),
                  label: FlutterI18n.translate(context, 'withdraw'),
                  onTap: state.balance.loading
                      ? null
                      : () =>
                          openSupernodeWithdraw(context, Token.supernodeDhx),
                )),
        Spacer(),
        CircleButton(
          icon: Image.asset(
            AppImages.iconMine,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'mine'),
          onTap: () {
            Navigator.push(context, route((c) => DhxMiningPage()));
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBars.backArrowSkipAppBar(
                      title: FlutterI18n.translate(context, 'tutorial_title'),
                      onPress: () => Navigator.pop(context),
                      action: FlutterI18n.translate(context, "skip")),
                  body: MiningTutorial(context),
                );
              },
            ));
          },
        ),
        Spacer(),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          builder: (ctx, state) => CircleButton(
              icon: Image.asset(
                AppImages.iconCouncil,
                color: (state.stakes.loading ||
                        state.stakes.value == null ||
                        state.stakes.value.isEmpty)
                    ? Colors.grey
                    : Token.supernodeDhx.color,
              ),
              label: FlutterI18n.translate(context, 'council'),
              onTap: () {
                final stakes = context.read<SupernodeDhxCubit>().state.stakes;
                if (stakes.loading ||
                    stakes.value == null ||
                    stakes.value.isEmpty) return;

                Set<String> argJoinedCouncils = state.stakes.value
                    .where((e) => !e.closed)
                    .map((e) => e.councilId)
                    .toSet();

                Navigator.pushNamed(
                  context,
                  'list_councils_page',
                  arguments: {
                    'isDemo':
                        context.read<SupernodeCubit>().state.session.isDemo,
                    'joinedCouncilsId': argJoinedCouncils,
                  },
                );
              }),
        ),
      ],
    );
  }
}

class SupernodeDhxMineActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton(
          icon: Icon(
            Icons.lock,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'lock_mxc'),
          onTap: () => Navigator.pushNamed(context, 'lock_page', arguments: {
            'isDemo': context.read<SupernodeCubit>().state.session.isDemo
          }),
        ),
        Spacer(),
        CircleButton(
          icon: Image.asset(
            AppImages.iconBond,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'bond'),
          onTap: () => Navigator.push(context, route((c) => DhxBondingPage())),
        ),
        Spacer(),
        CircleButton(
          icon: Image.asset(
            AppImages.iconUnbond,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'unbond'),
          onTap: () =>
              Navigator.push(context, route((c) => DhxUnbondingPage())),
        ),
        Spacer(),
        BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
          builder: (ctx, state) => CircleButton(
              icon: Icon(
                Icons.tune,
                color: (state.stakes.loading ||
                        state.stakes.value == null ||
                        state.stakes.value.isEmpty)
                    ? Colors.grey
                    : Token.supernodeDhx.color,
              ),
              label: FlutterI18n.translate(context, 'simulate_mining'),
              onTap: () {
                final stakes = context.read<SupernodeDhxCubit>().state.stakes;
                if (stakes.loading ||
                    stakes.value == null ||
                    stakes.value.isEmpty) return;

                Navigator.pushNamed(context, 'mining_simulator_page',
                    arguments: {
                      'isDemo':
                          context.read<SupernodeCubit>().state.session.isDemo,
                      'mxc_balance': context
                          .read<SupernodeUserCubit>()
                          .state
                          .balance
                          .value,
                      'dhx_balance':
                          context.read<SupernodeDhxCubit>().state.balance.value,
                    });
              }),
        ),
      ],
    );
  }
}
