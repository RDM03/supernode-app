import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/components/wallet/title_detail_row.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.model.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DepositDetailPage extends StatelessWidget {
  IconData icon;
  String title;
  String currency;
  String amount;
  String fee;
  String date;
  String status;
  String to_from;
  String hash;

  DepositDetailPage({this.icon, this.title, this.currency, this.amount, this.fee, this.date, this.status, this.to_from, this.hash});

  @override
  Widget build(BuildContext context) {
    String formatHash(String hash) {
      if (hash == null || hash.length < 20)
        return null;
      else
        return hash.replaceRange(7, hash.length - 7, '..');
    }
    
    return pageFrame(
      context: context,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      children: [
        Container(
          padding: kRoundRow15_5,
          child: pageNavBar(title,
              leadingWidget: SizedBox(),
              onTap: () => Navigator.pop(context)),
        ),
        SizedBox(height: 25),
        Container(
          padding: kRoundRow15_5,
          child: Row(children: [
            Container(
              width: s(50),
              height: s(50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Token.mxc.color,
                boxShadow: [
                  BoxShadow(
                    color: darkBackground,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text(title, style: kBigBoldFontOfBlack),
            Spacer(),
            Text('MXC/ETH', style: kBigFontOfBlack)
          ]),
        ),
        SizedBox(height: 25),
        TitleDetailRow(
          name: FlutterI18n.translate(context, 'amount'),
          value: amount,
          token: 'MXC',
        ),
        (fee != null)
            ? TitleDetailRow(
          name: FlutterI18n.translate(context, 'transaction_fee'),
          value: fee,
          token: 'MXC')
            : SizedBox(),
        TitleDetailRow(
          name: FlutterI18n.translate(context, 'date'),
          value: TimeUtil.getDatetime(date, type: 'date'),
          token: '',
        ),
        TitleDetailRow(
          name: FlutterI18n.translate(context, 'status'),
          value: status,
          token: '',
        ),
        TitleDetailRow(
          name: FlutterI18n.translate(context, 'txhash'),
          value: formatHash(hash),
          token: '',
          trail: IconButton(
            constraints: BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            padding: EdgeInsets.only(left: 8.0),
            icon: Icon(Icons.copy,
              color: Colors.black,
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: hash));
              tip(context, FlutterI18n.translate(context, 'has_copied'), success: true);
            },
          )
        ),
        TitleDetailRow(
          name: FlutterI18n.translate(context, 'to'),
          value: formatHash(hash),
          token: '',
          trail: IconButton(
            constraints: BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            padding: EdgeInsets.only(left: 8.0),
            icon: Icon(Icons.copy,
              color: Colors.black,
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: hash));
              tip(context, FlutterI18n.translate(context, 'has_copied'), success: true);
            },
          )
        ),
      ],
    );
  }
}