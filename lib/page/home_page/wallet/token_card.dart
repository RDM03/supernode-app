import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/wallet/cubit.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../bloc/supernode/wallet/state.dart';

class MxcTokenCard extends StatelessWidget {
  final bool isExpanded;

  const MxcTokenCard({Key key, this.isExpanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!context.read<WalletCubit>().state.expanded) {
          context.read<WalletCubit>().expandTo(WalletToken.mxc);
        }
      },
      child: PanelFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                padding: kRoundRow15_5,
                child: Row(
                  children: [
                    Image.asset(WalletToken.mxc.imagePath),
                    SizedBox(width: s(3)),
                    Text(WalletToken.mxc.name, style: kBigBoldFontOfBlack),
                    Spacer(),
                    if (isExpanded)
                      SizedBox()
                    else
                      Icon(Icons.arrow_forward_ios)
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
            ],
          ),
        ),
      ),
    );
  }
}

class SupernodeDhxTokenCard extends StatelessWidget {
  final bool isExpanded;
  const SupernodeDhxTokenCard({Key key, this.isExpanded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!context.read<WalletCubit>().state.expanded) {
          context.read<WalletCubit>().expandTo(WalletToken.supernodeDhx);
        }
      },
      child: PanelFrame(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                padding: kRoundRow15_5,
                child: Row(children: [
                  Image.asset(WalletToken.supernodeDhx.imagePath),
                  SizedBox(width: s(3)),
                  Text(WalletToken.supernodeDhx.name,
                      style: kBigBoldFontOfBlack),
                  Spacer(),
                  if (isExpanded)
                    PrimaryButton(
                      bgColor: colorToken[Token.DHX],
                      buttonTitle:
                          FlutterI18n.translate(context, 'simulate_mining'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        'mining_simulator_page',
                        arguments: {
                          'isDemo': context.read<AppCubit>().state.isDemo,
                          'balance': context
                              .read<SupernodeUserCubit>()
                              .state
                              .balance
                              .value,
                        },
                      ),
                    )
                  else
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
                  loading: state.balance.loading,
                  name: FlutterI18n.translate(context, 'locked_amount'),
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
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTokenCard extends StatelessWidget {
  void _showAddTokenDialog(BuildContext context) {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        context: context,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                FlutterI18n.translate(context, 'add_token_title'),
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
                Navigator.pop(context);
                context.read<WalletCubit>().addDhx();
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Image.asset(AppImages.logoDHX, height: s(50)),
                  SizedBox(width: s(10)),
                  Text(
                    'Datahighway DHX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddTokenDialog(context),
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
