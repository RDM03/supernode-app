import 'package:flutter/cupertino.dart';
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
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';

import 'stake_history.dart';
import 'transaction_history.dart';
import '../../shared.dart';

class MxcTokenPageContent extends StatefulWidget {
  const MxcTokenPageContent({Key key}) : super(key: key);

  @override
  _MxcTokenPageContentState createState() => _MxcTokenPageContentState();
}

class _MxcTokenPageContentState extends State<MxcTokenPageContent>
    with AutomaticKeepAliveClientMixin {
  void _showStakeDialog(BuildContext context) {
    showInfoDialog(
      context,
      IosStyleBottomDialog2(
        context: context,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                FlutterI18n.translate(context, 'staking'),
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
                openSupernodeStake(context);
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Image.asset(
                      AppImages.iconMine,
                      color: Token.mxc.color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'new_stake'),
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
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
                openSupernodeUnstake(context);
              },
              child: Row(
                children: [
                  CircleButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Token.mxc.color,
                    ),
                  ),
                  SizedBox(
                    width: s(10),
                  ),
                  Text(
                    FlutterI18n.translate(context, 'unstake'),
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

  @override
  bool get wantKeepAlive => true;

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Spacer(),
                CircleButton(
                  icon: Icon(
                    Icons.add,
                    color: Token.mxc.color,
                  ),
                  label: FlutterI18n.translate(context, 'deposit'),
                  onTap: () => openSupernodeDeposit(context),
                ),
                Spacer(),
                BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.balance != b.balance,
                  builder: (ctx, state) => CircleButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Token.mxc.color,
                    ),
                    label: FlutterI18n.translate(context, 'withdraw'),
                    onTap: state.balance.loading
                        ? null
                        : () => openSupernodeWithdraw(context),
                  ),
                ),
                Spacer(),
                BlocBuilder<SupernodeUserCubit, SupernodeUserState>(
                  buildWhen: (a, b) => a.balance != b.balance,
                  builder: (ctx, state) => CircleButton(
                    icon: Image.asset(
                      AppImages.iconMine,
                      color: Token.mxc.color,
                    ),
                    label: FlutterI18n.translate(context, 'stake'),
                    onTap: state.balance.loading
                        ? null
                        : () => _showStakeDialog(context),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          MxcTokenCard(isExpanded: true),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CupertinoSlidingSegmentedControl(
                groupValue: selectedTab,
                onValueChanged: (tabIndex) =>
                    setState(() => selectedTab = tabIndex),
                thumbColor: Token.mxc.color,
                children: <int, Widget>{
                  0: Text(
                    FlutterI18n.translate(context, 'transaction_history'),
                    style: TextStyle(
                      color: (selectedTab == 0) ? Colors.white : Colors.grey,
                    ),
                  ),
                  1: Text(
                    FlutterI18n.translate(context, 'stake_assets'),
                    style: TextStyle(
                      color: (selectedTab == 1) ? Colors.white : Colors.grey,
                    ),
                  )
                }),
          ),
          if (selectedTab == 0)
            TransactionHistoryContent()
          else
            StakeHistoryContent(),
        ],
      ),
    );
  }
}
