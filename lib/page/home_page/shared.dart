import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/theme/font.dart';
import 'bloc/supernode/user/cubit.dart';
import 'cubit.dart';

Future<void> openSettings(BuildContext context) async {
  if (context.read<SupernodeUserCubit>()?.state?.organizations?.loading ??
      false) return;
  return Navigator.pushNamed(
    context,
    'settings_page',
    arguments: {
      'isDemo': context.read<AppCubit>().state.isDemo,
      'user': context.read<SupernodeCubit>()?.state?.session,
      'organizations':
          context.read<SupernodeUserCubit>()?.state?.organizations?.value,
      'weChatUser': context.read<SupernodeUserCubit>()?.state?.weChatUser,
      'shopifyUser': context.read<SupernodeUserCubit>()?.state?.shopifyUser,
    },
  );
}

Future<void> openSupernodeDeposit(BuildContext context) async {
  final orgId = context.read<SupernodeCubit>().state.orgId;
  final userId = context.read<SupernodeCubit>().state.session.userId;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'deposit_page',
    arguments: {
      'userId': userId,
      'orgId': orgId,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeWithdraw(BuildContext context, Token token) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final balanceBTC = context.read<SupernodeBtcCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'withdraw_page',
    arguments: {
      'balance': balance.value,
      'balanceBTC': balanceBTC.value,
      'isDemo': isDemo,
      'tokenName': token.name,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeStake(BuildContext context) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'stake_page',
    arguments: {
      'balance': balance.value,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

Future<void> openSupernodeUnstake(BuildContext context) async {
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'unstake_page',
    arguments: {
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

Widget tokenItem(
  BuildContext context, {
  Image image,
  String title,
  String subtitle,
  Color color,
  VoidCallback onPressed,
  bool showTrailingLine = true,
}) =>
    SizedBox(
      height: s(62),
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 10,
              color: color,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        image,
                        SizedBox(width: s(10)),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: kBigBoldFontOfBlack,
                            ),
                            SizedBox(height: 5),
                            Text(
                              subtitle,
                              style: kMiddleFontOfGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (showTrailingLine)
                    Container(
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.3),
                      height: 1,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

void addTokenDialog(
  BuildContext context, {
  List<Token> displayedTokens,
  bool parachainConnected,
  bool supernodeConnected,
}) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      padding: EdgeInsets.only(top: 10, bottom: 30),
      builder: (ctx) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 32),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                FlutterI18n.translate(context, 'add_token_title'),
                style: kBigBoldFontOfBlack,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          tokenItem(
            context,
            image: Image.asset(AppImages.logoMXC, height: s(50)),
            title: 'MXC',
            subtitle: () {
              if (displayedTokens.contains(Token.mxc)) return 'Existing Token';
              if (!supernodeConnected) return 'Requires Supernode account';
              return 'Available';
            }(),
            color: Token.mxc.color,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeCubit>().addSupernodeDhx();
            },
          ),
          tokenItem(
            context,
            image: Image.asset(AppImages.logoDHX, height: s(50)),
            title: 'DHX',
            subtitle: () {
              if (displayedTokens.contains(Token.supernodeDhx))
                return 'Existing Token';
              if (!supernodeConnected) return 'Requires Supernode account';
              return 'Available';
            }(),
            color: Token.supernodeDhx.color,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeCubit>().addSupernodeDhx();
            },
          ),
          tokenItem(
            context,
            image: Image.asset(Token.btc.imagePath, height: s(50)),
            title: 'BTC',
            subtitle: () {
              if (displayedTokens.contains(Token.btc)) return 'Existing Token';
              if (!supernodeConnected) return 'Requires Supernode account';
              return 'Available';
            }(),
            color: Token.btc.color,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeCubit>().addSupernodeBtc();
            },
          ),
          tokenItem(
            context,
            image: Image.asset(AppImages.logoDHX, height: s(50)),
            title: 'DHX (Mainnet)',
            subtitle: () {
              if (displayedTokens.contains(Token.parachainDhx))
                return 'Existing Token';
              if (!parachainConnected) return 'Requires Datahighway account';
              return 'Available';
            }(),
            color: Token.parachainDhx.color,
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeCubit>().addSupernodeDhx();
            },
            showTrailingLine: false,
          ),
        ],
      ),
    ),
  );
}
