import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/route.dart';

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
            color: Colors.grey,
          ),
          label: FlutterI18n.translate(context, 'deposit'),
          onTap: () {},
        ),
        Spacer(),
        CircleButton(
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.grey,
          ),
          label: FlutterI18n.translate(context, 'withdraw'),
          onTap: () {},
        ),
        Spacer(),
        CircleButton(
          icon: Image.asset(
            AppImages.iconMine,
            color: Token.supernodeDhx.color,
          ),
          label: FlutterI18n.translate(context, 'mine'),
          onTap: () => Navigator.push(context, route((c) => DhxMiningPage())),
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
                    'isDemo': context.read<AppCubit>().state.isDemo,
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
          onTap: () => Navigator.pushNamed(context, 'lock_page',
              arguments: {'isDemo': context.read<AppCubit>().state.isDemo}),
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
          onTap: () => Navigator.push(context, route((c) => DhxUnbondingPage())),
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

                Navigator.pushNamed(
                    context,
                    'mining_simulator_page',
                    arguments: {
                    'isDemo': context.read<AppCubit>().state.isDemo,
                    'balance':
                    context.read<SupernodeUserCubit>().state.balance.value,
                    });
              }),
        ),
      ],
    );
  }
}
