import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/stake_page/details_stake_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    DetailsStakeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  final months = state.stake.months;
  Color iconColor;

  switch (months) {
    case 24:
      iconColor = stake24Color;
      break;
    case 12:
      iconColor = stake12Color;
      break;
    case 9:
      iconColor = stake9Color;
      break;
    case 6:
      iconColor = stake6Color;
      break;
    default:
      iconColor = stakeFlexColor;
      break;
  }
  if (months == 12) {
    iconColor = stake12Color;
  }

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'stake'),
          onTap: () => Navigator.pop(viewService.context)),
      SizedBox(height: 30),
      Row(
        children: [
          Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            child: Text(
              months == null ? '~' : months.toString(),
              style: Theme.of(_ctx).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
          ),
          SizedBox(width: 16),
          Text(
            months == null ? 'Stake Flex' : '$months Month Stake',
            style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text('MXC/ETH'),
        ],
      ),
      SizedBox(height: 30),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Transaction ID' + ' :'),
              Text(
                state.stake.id.toString(),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Stake Date' + ' :'),
              Text(
                formatDate(state.stake.startTime),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('End Date' + ' :'),
              Text(
                state.stake.lockTill == null
                    ? '-'
                    : formatDate(state.stake.lockTill),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('UnStake Date' + ' :'),
              Text(
                state.stake.endTime == null
                    ? '-'
                    : formatDate(state.stake.endTime),
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Amount' + ' :'),
              Text(
                state.stake.amount.toString() + ' MXC',
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Revenue' + ' :'),
              Text(
                state.stake.amount.toString() + ' MXC',
                style: kBigFontOfBlack,
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              state.stake.amount.toString() + ' MXC',
              style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (state.stake.endTime != null) ...[
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Unstaked',
                style: kBigFontOfGrey,
              ),
            ),
          ]
        ],
      ),
      SizedBox(height: 40),
      if (state.stake.endTime == null)
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            onTap: (state.stake.lockTill == null ||
                    state.stake.lockTill.isBefore(DateTime.now()))
                ? () {
                    dispatch(DetailsStakeActionCreator.unstake());
                  }
                : null,
            buttonTitle: submitText(_ctx, state),
          ),
        ),
    ],
  );
}

String formatDate(DateTime date) {
  return Tools.dateFormat(date);
}

String submitText(BuildContext ctx, DetailsStakeState state) {
  if (state.otpEnabled) return FlutterI18n.translate(ctx, 'unstake');
  return FlutterI18n.translate(ctx, 'unstake') +
      ' (' +
      FlutterI18n.translate(ctx, 'required_2FA_general') +
      ')';
}
