import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/loading_tiny.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'bloc/cubit.dart';
import 'bloc/state.dart';

class DepositPage extends StatefulWidget {
  final Token tkn;

  DepositPage(this.tkn);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  @override
  void initState() {
    context.read<DepositCubit>().loadAddress(widget.tkn.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
          title: FlutterI18n.translate(context, 'deposit'),
          onPress: () => Navigator.of(context).pop()),
      backgroundColor: backgroundColor,
      body: BlocBuilder<DepositCubit, DepositState>(
        buildWhen: (a, b) => a.address != b.address,
        builder: (ctx, s) {
          return PageBody(children: [
            smallColumnSpacer(),
            Text(
                FlutterI18n.translate(context, 'send_deposit_address')
                    .replaceFirst('{0}', widget.tkn.name),
                style: kBigFontOfBlack),
            Text(
                FlutterI18n.translate(context, 'send_coin_tip')
                    .replaceFirst('{0}', widget.tkn.name),
                style: kBigFontOfBlack),
            Text(
                FlutterI18n.translate(context, 'deposit_confirm_tip')
                    .replaceFirst('{0}', widget.tkn.name),
                style: kBigFontOfBlack),
            bigColumnSpacer(),
            Center(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  smallColumnSpacer(),
                  Image.asset(widget.tkn.imagePath),
                  Text(widget.tkn.name),
                  smallColumnSpacer(),
                  Divider(),
                  s.address.loading
                      ? loading(isSmall: true)
                      : QrImage(
                          key: Key('qrCodeTopUp'),
                          data: s.address.value,
                          foregroundColor: widget.tkn.color,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                  middleColumnSpacer(),
                  s.address.loading
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            s.address.value,
                            textAlign: TextAlign.center,
                            style: kMiddleFontOfGrey,
                            key: Key('ethAddressTopUp'),
                          ),
                        ),
                  middleColumnSpacer(),
                  s.address.loading
                      ? SizedBox()
                      : GestureDetector(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.copy, color: widget.tkn.color),
                                  SizedBox(width: 5),
                                  Text(
                                      FlutterI18n.translate(
                                          context, 'copy_address'),
                                      style: MiddleFontOfColor(
                                          color: widget.tkn.color)),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: widget.tkn.color.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                          onTap: () {
                            context.read<DepositCubit>().copy();
                            tip(FlutterI18n.translate(context, 'has_copied'),
                                success: true);
                          },
                        ),
                  middleColumnSpacer(),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: shodowColor,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                  ),
                ],
              ),
            )),
            middleColumnSpacer(),
            PrimaryButton(
                buttonTitle: FlutterI18n.translate(context, 'done'),
                bgColor: widget.tkn.color,
                onTap: () => Navigator.of(context).pop()),
            smallColumnSpacer(),
          ]);
        },
      ),
    );
  }
}
