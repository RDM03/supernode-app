import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';

part 'state.freezed.dart';

enum MinerStatsType { uptime, revenue, frameReceived, frameTransmitted }
enum MinerStatsTime { week, month, year }

@freezed
abstract class MinerStatsState with _$MinerStatsState {
  factory MinerStatsState(
      {@Default([]) List<MinerStatsEntity> originList,
      @Default([]) List<MinerStatsEntity> originMonthlyList,
       @Default([]) List<MinerStatsEntity> originYearlyList,
      @Default([]) List<double> xDataList,
      @Default([]) List<String> xLabelList,
      @Default([]) List<int> yLabelList,
      @Default(false) bool showLoading,
      @Default(MinerStatsTime.week) MinerStatsTime selectedTime,
      @Default(MinerStatsType.uptime) MinerStatsType selectedType,
      @Default(0) double uptimeWeekScore,
      @Default(0) int scrollFirstIndex,
      String error}) = _MinerStatsState;
}
