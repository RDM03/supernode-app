import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';

class SupernodeDhxActions extends StatelessWidget {
  void _showMineDXHDialog(BuildContext context, bool isDemo) {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        builder: (ctx) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                FlutterI18n.translate(context, 'mining'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
              onTap: () {
                Navigator.of(ctx).pop();

                Navigator.pushNamed(context, 'lock_page',
                    arguments: {'isDemo': isDemo});

                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBars.backArrowSkipAppBar(
                          onPress: () => Navigator.pop(context),
                          action: FlutterI18n.translate(context, "skip")),
                      body: MiningTutorial(context),
                    );
                  },
                ));
              },
              child: Row(
                children: [
                  CircleButton(
                      icon: Image.asset(AppImages.iconMine,
                          color: Token.supernodeDhx.color)),
                  SizedBox(width: s(10)),
                  Text(
                    FlutterI18n.translate(context, 'new_mining'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    CircleButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey)),
                    SizedBox(width: s(10)),
                    Text(
                      FlutterI18n.translate(context, 'unlock'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: s(16),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

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
          onTap: () => _showMineDXHDialog(
              context, context.read<AppCubit>().state.isDemo),
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
