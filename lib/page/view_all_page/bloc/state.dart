import 'package:fl_chart/fl_chart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';

part 'state.freezed.dart';

enum MinerStatsType { uptime, revenue, frameReceived, frameTransmitted }
enum MinerStatsTime { week, month, year }

@freezed
abstract class MinerStatsState with _$MinerStatsState {
  factory MinerStatsState({
    @Default([]) List<MinerStatsEntity> originList,
    @Default([]) List<double> xDataList,
    @Default([]) List<String> xLabelList,
    @Default([]) List<double> yLabelList,
    @Default(false) bool showLoading,
    @Default(MinerStatsTime.week) MinerStatsTime selectedTime,
    @Default(MinerStatsType.uptime) MinerStatsType selectedType,
    @Default(0) double uptimeWeekScore,
    String error
  }) = _MinerStatsState;
}