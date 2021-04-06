import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
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
      lastMiningPower: Wrap(
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
    emit(state.copyWith(balance: state.lastMiningPower.withLoading()));
    try {
      final lastMiningPowerData = await supernodeRepository.dhx.lastMining();
      final value = double.tryParse(lastMiningPowerData.dhxAmount);
      emit(state.copyWith(lastMiningPower: Wrap(value)));
      homeCubit.saveSNCache(CacheRepository.miningPowerKey, value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(lastMiningPower: state.lastMiningPower.withError(e)));
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
        mPower += Tools.convertDouble(stake.amount) *
            (1 + Tools.convertDouble(stake.boost));
        lockedAmount += Tools.convertDouble(stake.amount);
        totalRevenueDHX += Tools.convertDouble(stake.dhxMined);
      }

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

  Future<void> getBondInfo() async {
    try {
      emit(state.copyWith(dhxBonded:state.dhxBonded.withLoading(), dhxUnbonding: state.dhxUnbonding.withLoading()));
      final res = await supernodeRepository.dhx.bondInfo(
        organizationId: orgId,
      );

      final double dhxBonded = double.parse(res["dhxBonded"]);
      final double dhxUnbonding = double.parse(res["dhxUnbondingTotal"]);

      final List<CalendarModel> listCalendarData = [];
      try { // parsing response for calendar component on DhxMiningPage
        final Map<DateTime, CalendarModel> parsed = {};
        DateTime dateTmp;

        for (dynamic rec in res["dhxUnbonding"]) {
          dateTmp = DateTime.tryParse(rec["created"]) ?? DateTime.now();
          dateTmp = DateTime.utc(dateTmp.year, dateTmp.month, dateTmp.day);
          if (!parsed.containsKey(dateTmp))
            parsed[dateTmp] = CalendarModel(date: dateTmp);
          parsed[dateTmp].unbondAmount += double.parse(rec["amount"]);
        }

        for (dynamic rec in res["dhxCoolingOff"]) {
          dateTmp = DateTime.tryParse(rec["created"]) ?? DateTime.now();
          dateTmp = DateTime.utc(dateTmp.year, dateTmp.month, dateTmp.day);
          if (!parsed.containsKey(dateTmp))
            parsed[dateTmp] = CalendarModel(date: dateTmp);
          parsed[dateTmp].minedAmount += double.parse(rec["amount"]);
        }

        final List<DateTime> datesParsed = parsed.keys.toList()..sort();

        dateTmp = DateTime.now();
        final today = DateTime.utc(dateTmp.year, dateTmp.month, dateTmp.day);
        final DateTime firstDayOfRange = (datesParsed.length > 0) ? datesParsed[0] : today;
        final DateTime mondayBeforeFirstDay = firstDayOfRange.subtract(
            Duration(days: firstDayOfRange.weekday - 1));

        int indexDatesParsed = 0;
        for (int i = 0; i < 14; i++) {
          // 2 weeks range starting on Monday before bond-info data
          dateTmp = mondayBeforeFirstDay.add(Duration(days: i));
          if (indexDatesParsed < datesParsed.length &&
              dateTmp == datesParsed[indexDatesParsed]) {
            listCalendarData.add(parsed[dateTmp]
              ..today = (today
                  .difference(dateTmp)
                  .inDays == 0));
            if (indexDatesParsed == 0) {
              parsed[dateTmp].left = true;
            } else if (indexDatesParsed == datesParsed.length - 1) {
              parsed[dateTmp].right = true;
            } else {
              parsed[dateTmp].middle = true;
            }
            indexDatesParsed++;
          } else {
            listCalendarData.add(CalendarModel(date: dateTmp, today: (today
                .difference(dateTmp)
                .inDays == 0)));
          }
        }
      } catch (e, s) {
        logger.e('refresh error', e, s);
      }

      emit(state.copyWith(dhxBonded: Wrap(dhxBonded), dhxUnbonding: Wrap(dhxUnbonding), calendarBondInfo: listCalendarData));

    } catch (e, s) {
      logger.e('refresh error', e, s);
    }
  }

  Future<void> confirmBondUnbond({String bond = '0', String unbond = '0'}) async {
    emit(state.copyWith(confirm: true, bondAmount: double.parse(bond), unbondAmount: double.parse(unbond)));
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
      await supernodeRepository.dhx.unbondDhx(state.unbondAmount.toString(), orgId);

      refreshBalance();

      emit(state.copyWith(success: true, showLoading: false));
      emit(state.copyWith(success: false));
    } catch (e, s) {
      emit(state.copyWith(showLoading: false));
      logger.e('refresh error', e, s);
    }
  }
}
