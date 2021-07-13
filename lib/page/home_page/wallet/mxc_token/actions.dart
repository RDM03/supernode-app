import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/state.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/theme/colors.dart';

class MxcActions extends StatelessWidget {
  final bool spaceOut;

  const MxcActions({
    Key key,
    this.spaceOut = false,
  }) : super(key: key);

  void _showStakeDialog(BuildContext ctx) {
    showInfoDialog(
      ctx,
      IosStyleBottomDialog2(
        builder: (context) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                FlutterI18n.translate(context, 'staking'),
                style: TextStyle(
                  color: blackColor,
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(color: greyColor),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                openSupernodeStake(ctx);
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Image.asset(
                      AppImages.iconMine,
                      color: Token.mxc.ui(context).color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'new_stake'),
                    style: TextStyle(
                      color: blackColor,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: greyColor),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                openSupernodeUnstake(ctx);
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Token.mxc.ui(context).color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'unstake'),
                    style: TextStyle(
                      color: blackColor,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: greyColor),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (spaceOut) Spacer(),
        CircleButton(
          icon: Icon(
            Icons.add,
            color: Token.mxc.ui(context).color,
          ),
          label: FlutterI18n.translate(context, 'deposit'),
          onTap: () => openSupernodeDeposit(context, Token.mxc),
        ),
        Spacer(),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => CircleButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Token.mxc.ui(context).color,
            ),
            label: FlutterI18n.translate(context, 'withdraw'),
            onTap: state.balance.loading
                ? null
                : () => openSupernodeWithdraw(context, Token.mxc),
          ),
        ),
        Spacer(),
        BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
          buildWhen: (a, b) => a.balance != b.balance,
          builder: (ctx, state) => CircleButton(
            icon: Image.asset(
              AppImages.iconMine,
              color: Token.mxc.ui(context).color,
            ),
            label: FlutterI18n.translate(context, 'stake'),
            onTap:
                state.balance.loading ? null : () => _showStakeDialog(context),
          ),
        ),
        if (spaceOut) Spacer(),
      ],
    );
  }
}
