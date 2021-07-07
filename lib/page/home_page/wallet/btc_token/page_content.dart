import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/home_page/wallet/btc_token/actions.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'transactions_history.dart';
import 'package:supernodeapp/theme/spacing.dart';

class BtcTokenPageContent extends StatefulWidget {
  const BtcTokenPageContent({Key key}) : super(key: key);

  @override
  _BtcTokenPageContentState createState() => _BtcTokenPageContentState();
}

class _BtcTokenPageContentState extends State<BtcTokenPageContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: BtcActions(),
          ),
          BtcTokenCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: PanelFrame(
              rowTop: EdgeInsets.only(top: 00),
              customPanelColor: Token.btc.color,
              child: Container(
                padding: kRoundRow1505,
                alignment: Alignment.center,
                child: Text(
                  FlutterI18n.translate(context, 'transaction_history'),
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
          ),
          TransactionsHistoryContent(),
        ],
      ),
    );
  }
}
