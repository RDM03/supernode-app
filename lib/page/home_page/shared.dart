import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/mining_tutorial.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/deposit_page/bloc/cubit.dart';
import 'package:supernodeapp/page/deposit_page/deposit_page.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/gateway/add_miner/view.dart';
import 'package:supernodeapp/page/home_page/gateway/bloc/cubit.dart';
import 'package:supernodeapp/page/settings_page/settings_page.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/cubit.dart';
import 'package:supernodeapp/page/withdraw_page/withdraw_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../route.dart';
import 'package:supernodeapp/page/login_page/entry_parachain.dart';
import 'package:supernodeapp/page/login_page/entry_supernode.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/font.dart';
import 'bloc/supernode/dhx/cubit.dart';
import 'bloc/supernode/user/cubit.dart';
import 'cubit.dart';

void openSettings(BuildContext context) async {
  if (context.read<SupernodeUserCubit>()?.state?.organizations?.loading ??
      false) return;
  Navigator.push(context, route((context) => SettingsPage()));
}

Future<void> openSupernodeDeposit(BuildContext context, Token tkn) async {
  await Navigator.of(context).push(route((_) => BlocProvider(
      create: (ctx) => DepositCubit(context.read<SupernodeUserCubit>(),
          context.read<AppCubit>(), context.read<SupernodeRepository>()),
      child: DepositPage(tkn))));
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeWithdraw(BuildContext context, Token token) async {
  await Navigator.of(context).push(route((_) => BlocProvider(
      create: (ctx) => WithdrawCubit(context.read<SupernodeUserCubit>(),
          context.read<AppCubit>(), context.read<SupernodeRepository>()),
      child: WithdrawPage(token))));
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeDhxCubit>().refreshBalance();
  context.read<SupernodeBtcCubit>().refreshBalance();
}

Future<void> openSupernodeMiner(BuildContext context,
    {bool hasSkip = false}) async {
  await Navigator.of(context).push(MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: true,
      builder: (context) {
        return MultiBlocProvider(
            child: AddMinerPage(hasSkip: hasSkip),
            providers: [
              BlocProvider(
                  create: (ctx) => GatewayCubit(
                        orgId: context.read<SupernodeCubit>().state.orgId,
                        supernodeRepository:
                            context.read<SupernodeRepository>(),
                        homeCubit: !hasSkip ? context.read<HomeCubit>() : null,
                      )),
              BlocProvider(
                create: (ctx) => MinerCubit(
                    context.read<AppCubit>(),
                    context.read<SupernodeRepository>(),
                    context.read<SupernodeCubit>()),
              )
            ]);
      }));
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
    'list_unstake_page',
    arguments: {
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

void loginSupernode(BuildContext context) => Navigator.of(context).push(
      route((ctx) => EntrySupernodePage()),
    );

void loginParachain(BuildContext context) => Navigator.of(context).push(
      route((ctx) => EntryParachainPage()),
    );

Widget tokenItem(
  BuildContext context, {
  String key,
  Image image,
  String title,
  String subtitle,
  Color color,
  bool isSelected,
  VoidCallback onPressed,
  bool showTrailingLine = true,
  String suffix,
}) =>
    Container(
      height: s(62),
      foregroundDecoration: onPressed == null
          ? BoxDecoration(
              color: Colors.grey.shade300,
              backgroundBlendMode: BlendMode.saturation,
            )
          : null,
      child: GestureDetector(
        key: Key(key),
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
                            Row(children: [
                              Text(
                                title,
                                style: kBigBoldFontOfBlack,
                              ),
                              if (suffix != null) ...[
                                SizedBox(width: 5),
                                Text(
                                  suffix,
                                  style: kSmallFontOfGrey,
                                ),
                              ]
                            ]),
                            SizedBox(height: 5),
                            Text(
                              subtitle,
                              style: kMiddleFontOfGrey,
                            ),
                          ],
                        ),
                        Spacer(),
                        (isSelected != null)
                            ? Checkbox(
                                value: isSelected,
                                onChanged: (_) => onPressed(),
                                activeColor: Colors.grey,
                              )
                            : SizedBox(),
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
            key: 'addMXC',
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
              // MXC goes by default
            },
          ),
          tokenItem(
            context,
            key: 'addDHX',
            image: Image.asset(AppImages.logoDHX, height: s(50)),
            title: 'DHX',
            subtitle: () {
              if (displayedTokens.contains(Token.supernodeDhx))
                return 'Existing Token';
              if (!supernodeConnected) return 'Requires Supernode account';
              return 'Available';
            }(),
            color: Token.supernodeDhx.color,
            isSelected: displayedTokens.contains(Token.supernodeDhx),
            onPressed: () {
              Navigator.pop(ctx);
              if (!supernodeConnected) {
                loginSupernode(context);
              } else {
                context.read<HomeCubit>().toggleSupernodeDhx();
              }
            },
          ),
          tokenItem(
            context,
            key: 'addBTC',
            image: Image.asset(Token.btc.imagePath, height: s(50)),
            title: 'BTC',
            subtitle: () {
              if (displayedTokens.contains(Token.btc)) return 'Existing Token';
              if (!supernodeConnected) return 'Requires Supernode account';
              return 'Available';
            }(),
            color: Token.btc.color,
            isSelected: displayedTokens.contains(Token.btc),
            onPressed: () {
              Navigator.pop(ctx);
              if (!supernodeConnected) {
                loginSupernode(context);
              } else {
                context.read<HomeCubit>().toggleSupernodeBtc();
              }
            },
            showTrailingLine: false,
          ),
          tokenItem(
            context,
            key: 'addNFT',
            image: Image.asset(Token.nft.imagePath, height: s(50)),
            title: Token.nft.name,
            suffix: '(${FlutterI18n.translate(ctx, 'coming')})',
            subtitle: FlutterI18n.translate(ctx, 'nft_desc'),
            color: Token.nft.color,
            isSelected: false,
            showTrailingLine: false,
          ),
/*TODO uncomment for parachainDhx          ),
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
            isSelected: displayedTokens.contains(Token.parachainDhx),
            onPressed: () {
              Navigator.pop(ctx);
              if (!parachainConnected) {
                loginParachain(context);
              }
            },*/
        ],
      ),
    ),
  );
}

void showBoostMPowerDialog(BuildContext ctx) {
  showInfoDialog(
    ctx,
    IosStyleBottomDialog2(
      builder: (context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              FlutterI18n.translate(context, 'boost_mpower'),
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
            key: Key('shopM2proTap'),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
              launch(
                  'https://www.matchx.io/product/m2-pro-lpwan-crypto-miner/');
            },
            child: Row(
              children: [
                CircleButton(
                  icon: Icon(Icons.shopping_basket,
                      color: Token.supernodeDhx.color),
                ),
                SizedBox(
                  width: s(10),
                ),
                Text(
                  FlutterI18n.translate(context, 'shop_m2pro'),
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
            key: Key('lockPageTap'),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(ctx).pushNamed('lock_page', arguments: {
                'balance': ctx.read<SupernodeUserCubit>().state.balance.value,
                'isDemo': ctx.read<AppCubit>().state.isDemo,
              });
            },
            child: Row(
              children: [
                CircleButton(
                  icon: Icon(
                    Icons.lock,
                    color: Token.supernodeDhx.color,
                  ),
                ),
                SizedBox(
                  width: s(10),
                ),
                Text(
                  FlutterI18n.translate(context, 'lock_mxc'),
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
            key: Key('tutorialTitleTap'),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(ctx, MaterialPageRoute<void>(
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
            child: Row(
              children: [
                CircleButton(
                  icon: Image.asset(
                    AppImages.iconLearn,
                    color: Token.supernodeDhx.color,
                  ),
                ),
                SizedBox(
                  width: s(10),
                ),
                Text(
                  FlutterI18n.translate(context, 'learn_more'),
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
        ],
      ),
    ),
  );
}
