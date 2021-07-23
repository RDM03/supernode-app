import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';

import 'state.dart';

class SupernodeDhxCubit extends Cubit<SupernodeDhxState> {
  SupernodeDhxCubit({
    this.supernodeRepository,
    this.cacheRepository,
    this.orgId,
    this.session,
    this.homeCubit,
  }) : super(SupernodeDhxState());

  final HomeCubit homeCubit;
  final SupernodeSession session;
  final String orgId;
  final SupernodeRepository supernodeRepository;
  final CacheRepository cacheRepository;

  Future<void> initState() async {
    var data = homeCubit.loadSNCache();

    final newState = state.copyWith(
      balance: Wrap(
        data[CacheRepository.balanceDHXKey]?.toDouble(),
        loading: true,
      ),
      lockedAmount: Wrap(
        data[CacheRepository.lockedAmountKey]?.toDouble(),
        loading: true,
      ),
      yesterdayTotalMPower: Wrap(
        data[CacheRepository.miningPowerKey]?.toDouble(),
        loading: true,
      ),
      currentMiningPower: Wrap(
        data[CacheRepository.mPowerKey]?.toDouble(),
        loading: true,
      ),
      totalRevenue: Wrap(
        data[CacheRepository.totalRevenueDHXKey]?.toDouble(),
        loading: true,
      ),
    );

    emit(newState);
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshBalance(),
      refreshStakes(),
      refreshLastMining(),
      refreshTopups(),
      refreshWithdraws()
    ]);
  }

  Future<void> refreshBalance() async {
    emit(state.copyWith(balance: state.balance.withLoading()));
    try {
      final balanceData = await supernodeRepository.wallet.balance({
        'userId': session.userId,
        'orgId': orgId,
        'currency': 'DHX',
      });
      final value = Tools.convertDouble(balanceData['balance']);
      emit(state.copyWith(balance: Wrap(value)));
      homeCubit.saveSNCache(CacheRepository.balanceDHXKey, value);

      getBondInfo();
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(balance: state.balance.withError(e)));
    }
  }

  Future<void> refreshLastMining() async {
    emit(state.copyWith(
        yesterdayTotalMPower: state.yesterdayTotalMPower.withLoading()));
    try {
      final lastMiningPowerData = await supernodeRepository.dhx.lastMining();
      final value = double.tryParse(lastMiningPowerData.yesterdayTotalMPower);
      emit(state.copyWith(yesterdayTotalMPower: Wrap(value)));
      homeCubit.saveSNCache(CacheRepository.miningPowerKey, value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(
          yesterdayTotalMPower: state.yesterdayTotalMPower.withError(e)));
    }
  }

  Future<void> refreshStakes() async {
    emit(state.copyWith(
      lockedAmount: state.lockedAmount.withLoading(),
      totalRevenue: state.totalRevenue.withLoading(),
      currentMiningPower: state.currentMiningPower.withLoading(),
      stakes: state.stakes.withLoading(),
    ));
    try {
      final stakes = await supernodeRepository.dhx.listStakes(
        organizationId: orgId,
      );

      double lockedAmount = 0.0;
      double totalRevenueDHX = 0.0;
      double mPower = 0.0;

      for (final stake in stakes) {
        if (!stake.closed) {
          mPower += Tools.convertDouble(stake.amount) *
              (1 + Tools.convertDouble(stake.boost));
          lockedAmount += Tools.convertDouble(stake.amount);
        }
        totalRevenueDHX += Tools.convertDouble(stake.dhxMined);
      }

      int numGateways = 0;
      try {
        final res = await supernodeRepository.gateways
            .list({"organizationID": orgId, "offset": 0, "limit": 10});

        numGateways = int.parse(res['totalCount']);
      } catch (e, s) {
        logger.e('gateways error', e, s);
      }

      mPower += min(1000000 * numGateways, mPower);

      emit(state.copyWith(
        lockedAmount: Wrap(lockedAmount),
        totalRevenue: Wrap(totalRevenueDHX),
        currentMiningPower: Wrap(mPower),
        stakes: Wrap(stakes),
      ));

      homeCubit.saveSNCache(CacheRepository.lockedAmountKey, lockedAmount);
      homeCubit.saveSNCache(
          CacheRepository.totalRevenueDHXKey, totalRevenueDHX);
      homeCubit.saveSNCache(CacheRepository.mPowerKey, mPower);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(
        lockedAmount: state.lockedAmount.withError(e),
        totalRevenue: state.totalRevenue.withError(e),
        currentMiningPower: state.currentMiningPower.withError(e),
        stakes: state.stakes.withError(e),
      ));
    }
  }

  bool isExistItem(List<CalendarModel> data, DateTime date){
    return data.any((item) => TimeUtil.isSameDay(item.date, date));
  }

  Future<void> getBondInfo() async {
    try {
      emit(state.copyWith(
          dhxBonded: state.dhxBonded.withLoading(),
          dhxUnbonding: state.dhxUnbonding.withLoading()));

      DateTime startTime, endTime;
      DateTime nextMonth;

      if(state.calendarInfo != null && state.calendarInfo.isNotEmpty){
        String firstItem = state.calendarInfo.keys.first;
        CalendarModel item = (state.calendarInfo[firstItem])[0];
        endTime = item.date.add(Duration(days: -1));
      }

      endTime = endTime ?? DateTime.now();
      endTime = DateTime(endTime.year, endTime.month, 1);

      if(endTime.month + 1 <= 12) {
        nextMonth = DateTime(endTime.year, endTime.month + 1, 1);
      }else{
        nextMonth = DateTime(endTime.year + 1, 1, 1);
      }

      endTime = nextMonth.add(Duration(days: -1));

      if(startTime == null){
        if(endTime.month - 1 <= 0) {
          startTime = DateTime(endTime.year - 1, 12, 1);
        }else{
          startTime = DateTime(endTime.year, endTime.month - 1, 1);
        }
      }

      final resBondInfo = await supernodeRepository.dhx.bondInfo(
        organizationId: orgId,
      );

      final double dhxBonded = double.parse('0' + resBondInfo["dhxBonded"]);
      final double dhxUnbonding = double.parse('0' + resBondInfo["dhxUnbondingTotal"]);

      // final resBonding = await supernodeRepository.wallet.historyTransaction({
      //   'orgId': orgId,
      //   'currency': 'DHX',
      //   'paymentType': 'DHX_BONDING',
      //   'from': startTime.toUtc().toIso8601String(),
      //   'till': endTime.toUtc().toIso8601String()
      // });

      // final resUnBonding = await supernodeRepository.wallet.historyTransaction({
      //   'orgId': orgId,
      //   'currency': 'DHX',
      //   'paymentType': 'DHX_UNBONDING',
      //   'from': startTime.toUtc().toIso8601String(),
      //   'till': endTime.toUtc().toIso8601String()
      // });

      final Map<String, List<CalendarModel>> calendarInfo = {};

      try {
        final Map<DateTime, CalendarModel> parsed = {};
        DateTime dateTmp;

        for (dynamic rec in resBondInfo["dhxUnbonding"]) {
          if(rec["created"] != null){
            dateTmp = DateTime.tryParse(rec["created"]).toLocal();
            dateTmp = DateTime(dateTmp.year, dateTmp.month, dateTmp.day);
            if (!parsed.containsKey(dateTmp))
              parsed[dateTmp] = CalendarModel(date: dateTmp);
            parsed[dateTmp].unbondAmount += double.parse(rec["amount"]);
          }
        }

        for (dynamic rec in resBondInfo["dhxCoolingOff"]) {
          if(rec["created"] != null){
            dateTmp = DateTime.tryParse(rec["created"]).toLocal();
            dateTmp = DateTime(dateTmp.year, dateTmp.month, dateTmp.day);
            if (!parsed.containsKey(dateTmp))
              parsed[dateTmp] = CalendarModel(date: dateTmp);
            parsed[dateTmp].minedAmount += double.parse(rec["amount"]);
          }
        }

        final List<DateTime> datesParsed = parsed.keys.toList()..sort();

        int indexDatesParsed = 0;
        int lastDayBeforeToday = 0;

        dateTmp = DateTime.now();
        final today = DateTime(dateTmp.year, dateTmp.month, dateTmp.day);

        if (datesParsed.length > 0)
          lastDayBeforeToday = TimeUtil.isSameDay(datesParsed.last, today)
              ? datesParsed.length - 2
              : datesParsed.length - 1;

        for (int i = 0; i <= endTime.difference(startTime).inDays; i++) {
          dateTmp = startTime.add(Duration(days: i));
          if (indexDatesParsed < datesParsed.length &&
              dateTmp == datesParsed[indexDatesParsed]) {
            if (indexDatesParsed == 0) {
              parsed[dateTmp].left = true;
            }
            if (indexDatesParsed == lastDayBeforeToday) {
              parsed[dateTmp].right = true;
            }
            if (indexDatesParsed != 0 &&
                indexDatesParsed < lastDayBeforeToday) {
              parsed[dateTmp].middle = true;
            }
            parsed[dateTmp].today = TimeUtil.isSameDay(dateTmp, today);

            if(calendarInfo['${TimeUtil.getYM(dateTmp)}'] == null){
              calendarInfo['${TimeUtil.getYM(dateTmp)}'] = [];
            }

            if(!isExistItem(calendarInfo[TimeUtil.getYM(dateTmp)], dateTmp)){
              calendarInfo[TimeUtil.getYM(dateTmp)].add(parsed[dateTmp]);
            }

            indexDatesParsed++;
          } else {
            CalendarModel calendarTemp = CalendarModel(
                date: dateTmp, today: TimeUtil.isSameDay(dateTmp, today));
            
            if(calendarInfo[TimeUtil.getYM(dateTmp)] == null){
              calendarInfo[TimeUtil.getYM(dateTmp)] = [];
            }

            if(!isExistItem(calendarInfo[TimeUtil.getYM(dateTmp)], dateTmp)){
              calendarInfo[TimeUtil.getYM(dateTmp)].add(calendarTemp);
            }
          }
        }
      } catch (e, s) {
        logger.e('refresh error', e, s);
      }

      // for (dynamic rec in resUnBonding["tx"]) {
      //   DateTime dateTmp = rec["timestamp"] != null ? DateTime.tryParse(rec["timestamp"]) : DateTime.now();
      //   dateTmp = DateTime(dateTmp.year, dateTmp.month, dateTmp.day);
      //   for(int i = 0; i < calendarInfo[TimeUtil.getYM(dateTmp)].length; i++){
      //     CalendarModel item = calendarInfo[TimeUtil.getYM(dateTmp)][i];
      //     if(TimeUtil.isSameDay(item.date, dateTmp)){
      //       calendarInfo[TimeUtil.getYM(dateTmp)][i].unbondAmount += double.parse(rec["amount"]);
      //     }
      //   }
      // }

      state.calendarInfo.forEach((key, value) { 
        if(!calendarInfo.containsKey(key)){
          calendarInfo[key] = value;
        }
      });

      calendarInfo.keys.toList()..sort((a,b) => int.tryParse(a).compareTo(int.tryParse(b)));
      
      emit(state.copyWith(
          dhxBonded: Wrap(dhxBonded),
          dhxUnbonding: Wrap(dhxUnbonding),
          calendarInfo: calendarInfo));
    } catch (e, s) {
      logger.e('refresh error', e, s);
    }
  }

  Future<void> confirmBondUnbond(
      {String bond = '0', String unbond = '0'}) async {
    emit(state.copyWith(
        confirm: true,
        bondAmount: double.parse(bond),
        unbondAmount: double.parse(unbond)));
    emit(state.copyWith(confirm: false));
  }

  Future<void> bondDhx() async {
    try {
      emit(state.copyWith(showLoading: true));
      await supernodeRepository.dhx.bondDhx(state.bondAmount.toString(), orgId);

      refreshBalance();

      emit(state.copyWith(success: true, showLoading: false));
      emit(state.copyWith(success: false));
    } catch (e, s) {
      emit(state.copyWith(showLoading: false));
      logger.e('refresh error', e, s);
    }
  }

  Future<void> unbondDhx() async {
    try {
      emit(state.copyWith(showLoading: true));
      await supernodeRepository.dhx
          .unbondDhx(state.unbondAmount.toString(), orgId);

      refreshBalance();

      emit(state.copyWith(success: true, showLoading: false));
      emit(state.copyWith(success: false));
    } catch (e, s) {
      emit(state.copyWith(showLoading: false));
      logger.e('refresh error', e, s);
    }
  }

  Future<void> refreshTopups() async {
    emit(state.copyWith(topups: state.topups.withLoading()));
    try {
      final data = {
        'orgId': orgId,
        'from': DateTime(2000).toUtc().toIso8601String(),
        'till': DateTime.now().toUtc().add(Duration(days: 1)).toIso8601String(),
        'currency': 'DHX',
      };
      var history = await supernodeRepository.topup.history(data);
      emit(state.copyWith(topups: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(topups: state.topups.withError(e)));
    }
  }

  Future<void> refreshWithdraws() async {
    emit(state.copyWith(withdraws: state.withdraws.withLoading()));
    try {
      final data = {
        'orgId': orgId,
        'from': DateTime(2000).toUtc().toIso8601String(),
        'till': DateTime.now().toUtc().add(Duration(days: 1)).toIso8601String(),
        'currency': 'DHX',
      };
      var history = await supernodeRepository.withdraw.history(data);
      emit(state.copyWith(withdraws: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(withdraws: state.withdraws.withError(e)));
    }
  }
}
