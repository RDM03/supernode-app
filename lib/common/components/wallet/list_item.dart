import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import '../row_spacer.dart';

Widget listItem({BuildContext context,String type = '',String datetime,String secondDateTime,double amount = 0,double revenue = 0,double fee = 0,String fromAddress,String toAddress,String txHashAddress,String status,bool isExpand = true,bool isLast = false,Function onTap}){

  return Column(
    children: <Widget>[
      ListTile(
        onTap: onTap,
        // contentPadding: EdgeInsets.zero,
        title: Row(
          children: <Widget>[
            Text(
              'MXC/ETH',
              style: kBigFontOfBlack,
            ),
            smallRowSpacer(),
            Visibility(
              visible: !type?.contains('SEARCH') && !type?.contains('STAKE') && !type?.contains('UNSTAKE'),
              child: Expanded(
                child: Text(
                  '(${FlutterI18n.translate(context,type)})',
                  overflow: TextOverflow.ellipsis,
                  style: type?.contains('DEPOSIT') ? kSmallFontOfGreen : kSmallFontOfRed
                ),
              )
            ),
          ],
        ),
        subtitle: Text(
         revenue != null ? '${Tools.priceFormat(revenue,range: 2)} MXC ${TimeDao.getDatetime(datetime)}' : TimeDao.getDatetime(datetime),
          style: kSmallFontOfGrey,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: kRoundRow5,
              decoration: BoxDecoration(
                color: amount <= 0 || type?.contains('STAKE') ? null : depositColor,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Text(
                '${Tools.convertDouble(amount)} MXC',
                style: kBigFontOfBlack,
              ),
            ),
            Visibility(
              visible: secondDateTime != null,
              child: Text(
                TimeDao.getDatetime(secondDateTime),
                style: kSmallFontOfGrey,
              )
            )
          ]
        )
      ),
      Visibility(
        visible: true,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: type?.contains('WITHDRAW'),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                child: Row(
                children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,'transaction_fee'),
                      style: kMiddleFontOfGrey
                    ),
                    Spacer(),
                    Text(
                      '${Tools.convertDouble(fee)} MXC',
                      style: kMiddleFontOfGrey
                    )
                  ],
                ),
              ),
            ),
            ( fromAddress != null && toAddress != null ) ? Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 5,bottom: 15),
              child: Row(
              children: <Widget>[
                  Text(
                    FlutterI18n.translate(context,'from'),
                    style: kMiddleFontOfGrey
                  ),
                  smallRowSpacer(),
                  Container(
                    padding: kRoundRow5,
                    decoration: kRowShodow,
                    child: GestureDetector(
                      onTap: (){},
                      child: Text(
                        Tools.hideHalf(fromAddress) ?? '',
                        style: kSmallFontOfGrey,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    FlutterI18n.translate(context,'to'),
                    style: kMiddleFontOfGrey
                  ),
                  smallRowSpacer(),
                  Container(
                    padding: kRoundRow5,
                    decoration: kRowShodow,
                    child: GestureDetector(
                      onTap: (){},
                      child: Text(
                        Tools.hideHalf(toAddress) ?? '',
                        style: kSmallFontOfGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            txHashAddress != null ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
              children: <Widget>[
                  Text(
                    FlutterI18n.translate(context,'txhash'),
                    style: kMiddleFontOfGrey
                  ),
                  smallRowSpacer(),
                  Container(
                    padding: kRoundRow5,
                    decoration: kRowShodow,
                    // width: 100,
                    child: GestureDetector(
                      onTap: (){},
                      child: Text(
                        Tools.hideHalf(txHashAddress),
                        style: kSmallFontOfGrey,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                      "${FlutterI18n.translate(context,status.toLowerCase())}",
                    style: status != null && status.toLowerCase()?.contains('success') ? kMiddleFontOfGreen :
                    kMiddleFontOfRed
                  ),
                ],
              ),
            ) : Container(),
          ]
        )
      ),
      isLast ? Container() : Divider()
    ],
  );
}