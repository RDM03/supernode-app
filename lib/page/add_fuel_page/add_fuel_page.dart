import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/sliver_footer.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/add_fuel_page/confirm_page.dart';
import 'package:supernodeapp/page/add_fuel_page/proceed_dialog.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'filter_dialog.dart';

class AddFuelPage extends StatefulWidget {
  @override
  _AddFuelPageState createState() => _AddFuelPageState();
}

class _AddFuelPageState extends State<AddFuelPage> {
  Widget addFuelMessage() => Row(
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
                  'Add Fuel',
                  style: kBigBoldFontOfBlack,
                ),
                Text(
                  'Your miners are like cars, need MXC Fuel to continue mining.',
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
                'Fuel all',
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
                  AppImages.fuelIcon,
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
                Text('To 100% : ', style: kSmallFontOfGrey),
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
      Navigator.of(context).push(route((ctx) => AddFuelConfirmPage()));
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
        title: 'Add Fuel',
        onPress: () => Navigator.of(context).pop(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                addFuelMessage(),
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
                        onTap: () => onNext(context),
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
