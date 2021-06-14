import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../row_spacer.dart';

Widget listItem({
  Key key,
  BuildContext context,
  String type = '',
  String followText,
  TextStyle followStyle,
  Color amountColor,
  String amountText,
  String datetime,
  String secondDateTime,
  double amount = 0,
  double revenue = 0,
  double fee = 0,
  String fromAddress,
  String toAddress,
  String txHashAddress,
  String status,
  bool isExpand = true,
  bool isLast = false,
  Function onTap,
  Token token,
}) {
  final subtitle = (revenue != null && revenue != 0.0)
      ? '${Tools.priceFormat(revenue, range: 2)} MXC ${TimeUtil.getDatetime(datetime)}'
      : TimeUtil.getDatetime(datetime);
  amountColor ??=
      amount <= 0 || type.contains('STAKE') ? withdrawColor : depositColor;
  amountText ??=
      secondDateTime != null ? TimeUtil.getDatetime(secondDateTime) : null;
  if (!type.contains('SEARCH') &&
      !type.contains('STAKE') &&
      !type.contains('UNSTAKE')) {
    followText ??= '(${FlutterI18n.translate(context, type.toLowerCase())})';
  }
  followStyle ??=
      type.contains('DEPOSIT') ? kSmallFontOfGreen : kSmallFontOfRed;

  return Column(
    children: <Widget>[
      ListTile(
        key: key,
        onTap: onTap,
        // contentPadding: EdgeInsets.zero,
        title: Row(
          children: <Widget>[
            Text(
              token == Token.supernodeDhx ? 'DHX' : ( token == Token.btc ? 'BTC' : 'MXC/ETH'),
              style: kBigFontOfBlack,
            ),
            smallRowSpacer(),
            Visibility(
                visible: followText != null,
                child: Expanded(
                  child: Text(followText ?? '',
                      overflow: TextOverflow.ellipsis, style: followStyle),
                )),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: kSmallFontOfGrey,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: kRoundRow5,
              decoration: BoxDecoration(
                color: amountColor,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Text(
                '${Tools.convertDouble(amount)} ${token?.name}',
                style: kBigFontOfBlack,
              ),
            ),
            Visibility(
                visible: amountText != null,
                child: Text(
                  amountText ?? '',
                  style: kSmallFontOfGrey,
                ))
          ],
        ),
      ),
      Visibility(
        visible: true,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: type?.contains('WITHDRAW'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, 'transaction_fee'),
                        style: kMiddleFontOfGrey),
                    Spacer(),
                    Text('${Tools.convertDouble(fee)} MXC',
                        style: kMiddleFontOfGrey)
                  ],
                ),
              ),
            ),
            (fromAddress != null && toAddress != null)
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 5, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, 'from'),
                            style: kMiddleFontOfGrey),
                        smallRowSpacer(),
                        Container(
                          padding: kRoundRow5,
                          decoration: kRowShodow,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              Tools.hideHalf(fromAddress) ?? '',
                              style: kSmallFontOfGrey,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(FlutterI18n.translate(context, 'to'),
                            style: kMiddleFontOfGrey),
                        smallRowSpacer(),
                        Container(
                          padding: kRoundRow5,
                          decoration: kRowShodow,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              Tools.hideHalf(toAddress) ?? '',
                              style: kSmallFontOfGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            txHashAddress != null
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, 'txhash'),
                            style: kMiddleFontOfGrey),
                        smallRowSpacer(),
                        Container(
                          padding: kRoundRow5,
                          decoration: kRowShodow,
                          // width: 100,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              Tools.hideHalf(txHashAddress),
                              style: kSmallFontOfGrey,
                            ),
                          ),
                        ),
                        Spacer(),
                        if (token == Token.supernodeDhx)
                          Text(
                            "${FlutterI18n.translate(context, status.toLowerCase())}",
                            style: followStyle)
                        else
                          Text(
                              "${FlutterI18n.translate(context, status.toLowerCase())}",
                              style: status != null &&
                                      status.toLowerCase().contains(RegExp(
                                          '${FlutterI18n.translate(context, "success")}|success|completed'))
                                  ? kMiddleFontOfGreen
                                  : kMiddleFontOfRed),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      isLast ? Container() : Divider(),
    ],
  );
}

class TopupListItem extends StatelessWidget {
  final TopupEntity entity;
  final Token token;
  final TextStyle paymentTextStyle;
  final Color amountColor;

  const TopupListItem({Key key, this.entity, this.token = Token.mxc, this.paymentTextStyle, this.amountColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String followText;
    TextStyle followStyle;
    if (entity.amountDouble > 0) {
      followText = '(' + FlutterI18n.translate(context, 'deposit') + ')';
      followStyle = paymentTextStyle != null ? paymentTextStyle : kSmallFontOfGreen;
    }
    if (entity.amountDouble < 0) {
      followText = '(' + FlutterI18n.translate(context, 'withdraw') + ')';
      followStyle =  paymentTextStyle != null ? paymentTextStyle : kSmallFontOfRed;
    }
    return listItem(
      context: context,
      amount: entity.amountDouble,
      datetime: entity.timestamp.toIso8601String(),
      txHashAddress: entity.txHash,
      followText: followText,
      followStyle: followStyle,
      amountColor: amountColor,
      token: token,
      status: FlutterI18n.translate(context, 'completed'),
    );
  }
}

class WithdrawListItem extends StatelessWidget {
  final WithdrawHistoryEntity entity;
  final TextStyle paymentTextStyle;
  final Color amountColor;
  final Token token;

  const WithdrawListItem({
    Key key,
    this.entity,
    this.paymentTextStyle,
    this.amountColor,
    @required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String followText;
    TextStyle followStyle;
    if (entity.amountDouble > 0) {
      followText = '(' + FlutterI18n.translate(context, 'deposit') + ')';
      followStyle = paymentTextStyle != null ? paymentTextStyle : kSmallFontOfGreen;
    }

    if (entity.amountDouble < 0) {
      followText = '(' + FlutterI18n.translate(context, 'withdraw') + ')';
      followStyle =  paymentTextStyle != null ? paymentTextStyle : kSmallFontOfRed;
    }

    return listItem(
      context: context,
      amount: entity.amountDouble,
      //fee: entity.withdrawFee,
      datetime: entity.timestamp.toIso8601String(),
      txHashAddress: entity.txHash,
      followText: followText,
      followStyle: followStyle,
      amountColor: amountColor,
      token: token,
      status: entity.txStatus != null
          ? FlutterI18n.translate(context, entity.txStatus)
          : FlutterI18n.translate(context, 'completed'),
    );
  }
}
