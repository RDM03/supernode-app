import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';

import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/value_listenable.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/dhx.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/home_page/shared.dart';
import 'package:supernodeapp/page/mining_simulator_page/widgets/action_button.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';
import 'widgets/value_editor.dart';

Widget buildView(
    MiningSimulatorState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return GestureDetector(
    key: Key('miningSimulatorView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: Form(
      key: state.formKey,
      child: pageFrame(
        context: viewService.context,
        resizeToAvoidBottomInset: true,
        children: [
          pageNavBar(FlutterI18n.translate(_ctx, 'mining_simulator'),
              leadingWidget: SizedBox(),
              onTap: () => Navigator.pop(viewService.context)),
          SizedBox(height: 35),
          ValueEditor(
            key: ValueKey('mxcValueEditor'),
            controller: state.mxcLockedCtl,
            total: double.parse(Tools.priceFormat(state.mxcBalance, range: 2)),
            title: FlutterI18n.translate(_ctx, 'mxc_locked'),
            subtitle: FlutterI18n.translate(_ctx, 'current_mxc_balance'),
            textFieldSuffix: 'MXC',
            totalSuffix: 'MXC',
          ),
          SizedBox(height: 35),
          Text(
            FlutterI18n.translate(_ctx, 'mxc_lockdrop_duration'),
            style: kBigFontOfBlack,
          ),
          MxcSliderTheme(
            child: Slider(
              key: ValueKey('monthsSlider'),
              value: monthsOptions.indexOf(state.months).toDouble(),
              max: (monthsOptions.length - 1).toDouble(),
              divisions: (monthsOptions.length - 1),
              activeColor: Token.supernodeDhx.color,
              inactiveColor: Token.supernodeDhx.color.withOpacity(0.2),
              onChanged: (v) => dispatch(MiningSimulatorActionCreator.months(
                  monthsOptions[v.toInt()])),
            ),
          ),
          Text(
            FlutterI18n.translate(_ctx, 'months_lockdrop_duration')
                .replaceAll('{0}', state.months.toString())
                .replaceAll('{1}', () {
              final boostRate = monthsToBoost(state.months);
              final boostRatePercents = (boostRate * 100).round();
              return boostRatePercents == 0
                  ? FlutterI18n.translate(_ctx, 'no_boost')
                  : FlutterI18n.translate(_ctx, 'x_boost')
                      .replaceAll('{0}', '$boostRatePercents%');
            }()),
            style: kSmallFontOfGrey,
          ),
          SizedBox(height: 35),
          ValueEditor(
            key: ValueKey('minersValueEditor'),
            controller: state.minersAmountCtl,
            total: state.minersTotal,
            title: FlutterI18n.translate(_ctx, 'amount_of_miner'),
            subtitle: FlutterI18n.translate(_ctx, 'amount_of_miner_desc'),
            textFieldSuffix: FlutterI18n.translate(_ctx, 'miner'),
            showSlider: false,
          ),
          middleColumnSpacer(),
          PanelFrame(
            child: Column(
              children: [
                smallColumnSpacer(),
                Center(
                    child: Text(
                  FlutterI18n.translate(_ctx, 'simulator_results'),
                  style: kBigBoldFontOfBlack,
                )),
                bigColumnSpacer(),
                Center(
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      FlutterI18n.translate(_ctx, 'estimated_mining_power'),
                      style: kSmallFontOfGrey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: ValueListenableBuilder2(
                      state.minersAmountCtl, state.mxcLockedCtl, builder: (ctx,
                          TextEditingValue miners, TextEditingValue mxc, _) {
                    final mPower = getMPower(state, mxc.text, miners.text);
                    final res =
                        mPower == null ? null : Tools.numberRounded(mPower);
                    return Text(
                      (res ?? '??'),
                      key: ValueKey('mPowerText'),
                      style: kPrimaryBigFontOfBlack,
                    );
                  }),
                ),
                SizedBox(height: 8),
                if (state.calculateExpandState ==
                    CalculateExpandState.notExpanded)
                  Center(
                    child: SmallActionButton(
                      key: ValueKey('mPowerButton'),
                      text: 'mPower',
                      onTap: () => dispatch(
                          MiningSimulatorActionCreator.expandCalculation(
                              CalculateExpandState.mPower)),
                    ),
                  ),
                if (state.calculateExpandState == CalculateExpandState.mPower)
                  ValueListenableBuilder2(
                      state.minersAmountCtl, state.mxcLockedCtl, builder: (ctx,
                          TextEditingValue miners, TextEditingValue mxc, _) {
                    final mPower = getMPower(state, mxc.text, miners.text);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: SmallActionButton(
                        key: ValueKey('mPowerExpandedButton'),
                        width: double.infinity,
                        text: (mPower == null || mPower.isNaN
                                ? '??'
                                : mPower.toStringAsFixed(0)) +
                            ' mPower',
                        onTap: () => dispatch(
                            MiningSimulatorActionCreator.expandCalculation(
                                CalculateExpandState.notExpanded)),
                      ),
                    );
                  }),
                middleColumnSpacer(),
                Container(
                  padding: kRoundRow15_5,
                  child: Row(
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(_ctx, 'estimated_dhx_daily'),
                        textAlign: TextAlign.left,
                        style: kSmallFontOfGrey,
                      ),
                      Spacer(),
                      ValueListenableBuilder3(state.minersAmountCtl,
                          state.mxcLockedCtl, state.dhxBondedCtl, builder: (ctx,
                              TextEditingValue miners,
                              TextEditingValue mxc,
                              TextEditingValue dhx,
                              _) {
                        final dailyReturn =
                            getDailyReturn(state, mxc.text, miners.text);
                        final res = dailyReturn == null || dailyReturn.isNaN
                            ? null
                            : '${Tools.priceFormat(dailyReturn, range: 2)} ${Token.supernodeDhx.name}';
                        return Text(
                          (res ?? '??'),
                          key: ValueKey('dailyText'),
                          style: kBigFontOfBlack,
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  padding: kRoundRow15_5,
                  child: Row(
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(
                            _ctx, 'bond_amount_for_max_mining'),
                        textAlign: TextAlign.left,
                        style: kSmallFontOfGrey,
                      ),
                      Spacer(),
                      ValueListenableBuilder3(state.minersAmountCtl,
                          state.mxcLockedCtl, state.dhxBondedCtl, builder: (ctx,
                              TextEditingValue miners,
                              TextEditingValue mxc,
                              TextEditingValue dhx,
                              _) {
                        final dailyReturn =
                            getDailyReturn(state, mxc.text, miners.text);
                        final res = dailyReturn == null || dailyReturn.isNaN
                            ? null
                            : '${Tools.priceFormat(70 * dailyReturn, range: 2)} ${Token.supernodeDhx.name}';
                        return Text(
                          (res ?? '??'),
                          key: ValueKey('dailyText'),
                          style: kBigFontOfBlack,
                        );
                      }),
                    ],
                  ),
                ),
                middleColumnSpacer(),
              ],
            ),
          ),
          xbigColumnSpacer(),
          PrimaryButton(
            key: Key('boostMpowerButton'),
            buttonTitle: FlutterI18n.translate(_ctx, 'boost_mpower'),
            bgColor: Token.supernodeDhx.color,
            minWidth: double.infinity,
            onTap: () => showBoostMPowerDialog(_ctx),
          ),
          middleColumnSpacer(),
        ],
      ),
    ),
  );
}

double getDailyReturn(
    MiningSimulatorState state, String mxcText, String minersText) {
  final mxcLocked = double.tryParse(mxcText);
  final minersCount = int.tryParse(minersText);
  return calculateDhxDaily(
    minersCount: minersCount,
    months: state.months,
    mxcLocked: mxcLocked,
    yesterdayTotalDHX: state.yesterdayTotalDHX,
    yesterdayTotalMPower: state.yesterdayTotalMPower,
  );
}

double getMPower(
    MiningSimulatorState state, String mxcText, String minersText) {
  final mxcValue = double.tryParse(mxcText);
  final minersCount = int.tryParse(minersText);
  return mxcValue == null || minersCount == null
      ? null
      : calculateMiningPower(
          mxcValue, minersCount, monthsToBoost(state.months));
}
