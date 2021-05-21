import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/send_to_wallet_page/confirm_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/common/components/sliver_footer.dart';

import 'filter_dialog.dart';
import 'proceed_dialog.dart';

class SendToWalletPage extends StatefulWidget {
  @override
  _SendToWalletPageState createState() => _SendToWalletPageState();
}

class _SendToWalletPageState extends State<SendToWalletPage> {
  Widget sendToWalletMessage() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(AppImages.fuelCircle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Send To Wallet',
                  style: kBigBoldFontOfBlack,
                ),
                Text(
                  'Please note you will lose your mining efficiency once you send to the wallet',
                ),
              ],
            ),
          ),
        ],
      );

  Widget selectAll() => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 0.5),
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              child: ButtonTheme(
                padding: EdgeInsets.zero,
                child: PrimaryButton(
                  onTap: () {},
                  buttonTitle: 'Select all',
                  bgColor: healthColor,
                  minWidth: 0,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Send all',
                textAlign: TextAlign.right,
                style: kBigFontOfBlack,
              ),
            ),
            SizedBox(width: 5),
            Switch(
              value: false,
              onChanged: (v) {},
              inactiveThumbColor: Colors.grey.shade700,
              activeColor: healthColor,
            ),
          ],
        ),
      );

  Widget gatewayItem() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                Expanded(
                    child: Text(
                  'M2PRO',
                  style: kBigFontOfBlack,
                )),
                Image.asset(
                  AppImages.gateways,
                  height: 16,
                  color: colorMxc,
                ),
                SizedBox(width: 6),
                Text(
                  '90%',
                  style: kBigFontOfBlack,
                ),
                SizedBox(width: 18),
                Image.asset(
                  AppImages.fuel,
                  color: fuelColor,
                  height: 16,
                ),
                SizedBox(width: 6),
                Text(
                  '90%',
                  style: kBigFontOfBlack,
                ),
                SizedBox(width: 16),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 20,
                child: MxcSliderTheme(
                  child: Slider(
                    value: 0.4,
                    onChanged: (v) {},
                    activeColor: healthColor,
                    inactiveColor: healthColor.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Text('Current Fuel : ', style: kSmallFontOfGrey),
                Text(
                  '1000 MXC',
                  style: kSmallFontOfBlack.copyWith(color: healthColor),
                ),
                Spacer(),
                ColoredText(
                  text: '0 MXC',
                  color: healthColor.withOpacity(0.2),
                  style: kMiddleFontOfBlack,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],
        ),
      );

  void onFilter() {
    showInfoDialog(
      context,
      filterDialog(),
    );
  }

  Future<void> onNext(BuildContext context) async {
    final res = await showCupertinoModalPopup(
          context: context,
          builder: (ctx) => proceedDialog(ctx),
        ) ??
        false;
    if (res) {
      Navigator.of(context).push(route((ctx) => SendToWalletConfirmPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        action: IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: onFilter,
          color: Colors.black,
        ),
        title: 'Send to Wallet',
        onPress: () {
          Navigator.of(context).pop();
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                sendToWalletMessage(),
                SizedBox(height: 19),
                selectAll(),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                gatewayItem(),
                gatewayItem(),
              ],
            ),
          ),
          // TODO: No items warning
          SliverFooter(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(height: 0.5, color: Colors.grey.shade200),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      '0 MXC',
                      style: kVeryBigFontOfBlack.copyWith(color: healthColor),
                    ),
                  ),
                  SizedBox(height: 9),
                  Center(
                    child: Text(
                      'Send amount',
                      style: kMiddleFontOfGrey,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PrimaryButton(
                        onTap: () => Navigator.of(context)
                            .push(route((ctx) => SendToWalletConfirmPage())),
                        minHeight: 46,
                        buttonTitle: 'Next',
                        bgColor: healthColor,
                        minWidth: 0,
                        textStyle: kBigFontOfWhite,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
