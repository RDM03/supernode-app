import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.model.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class SupernodeDhxState with _$SupernodeDhxState {
  factory SupernodeDhxState({
    @Default(Wrap.pending()) Wrap<double> balance,
    @Default(Wrap.pending()) Wrap<double> lockedAmount,
    @Default(Wrap.pending()) Wrap<double> totalRevenue,
    @Default(Wrap.pending()) Wrap<double> lastMiningPower,
    @Default(Wrap.pending()) Wrap<double> currentMiningPower,
    @Default(Wrap.pending()) Wrap<List<StakeDHX>> stakes,
    @Default(Wrap.pending()) Wrap<double> dhxBonded,
    @Default(Wrap.pending()) Wrap<double> dhxUnbonding,
    @Default([]) List<CalendarModel> calendarBondInfo,
    @Default(false) bool confirm,
    @Default(false) bool success,
    @Default(false) bool showLoading,
    double bondAmount,
    double unbondAmount,
  }) = _SupernodeDhxState;
}

class CalendarModel {
  final bool left, right, middle, today;
  final int day;
  final int minedAmount;
  final int unbondAmount;

  CalendarModel({this.left = false, this.right = false, this.middle = false, this.today = false, this.day, this.minedAmount = 0, this.unbondAmount = 0});
}