// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MinerStatsStateTearOff {
  const _$MinerStatsStateTearOff();

// ignore: unused_element
  _MinerStatsState call(
      {List<MinerStatsEntity> originList = const [],
      List<MinerStatsEntity> originMonthlyList = const [],
      List<MinerStatsEntity> originYearlyList = const [],
      List<double> xDataList = const [],
      List<String> xLabelList = const [],
      List<int> yLabelList = const [],
      bool showLoading = false,
      MinerStatsTimePeriod selectedTimePeriod = MinerStatsTimePeriod.week,
      MinerStatsType selectedType = MinerStatsType.uptime,
      double uptimeWeekScore = 0,
      int currentIndex = -1,
      String upperLabel = '',
      String statsLabel = '',
      String error}) {
    return _MinerStatsState(
      originList: originList,
      originMonthlyList: originMonthlyList,
      originYearlyList: originYearlyList,
      xDataList: xDataList,
      xLabelList: xLabelList,
      yLabelList: yLabelList,
      showLoading: showLoading,
      selectedTimePeriod: selectedTimePeriod,
      selectedType: selectedType,
      uptimeWeekScore: uptimeWeekScore,
      currentIndex: currentIndex,
      upperLabel: upperLabel,
      statsLabel: statsLabel,
      error: error,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MinerStatsState = _$MinerStatsStateTearOff();

/// @nodoc
mixin _$MinerStatsState {
  List<MinerStatsEntity> get originList;
  List<MinerStatsEntity> get originMonthlyList;
  List<MinerStatsEntity> get originYearlyList;
  List<double> get xDataList;
  List<String> get xLabelList;
  List<int> get yLabelList;
  bool get showLoading;
  MinerStatsTimePeriod get selectedTimePeriod;
  MinerStatsType get selectedType;
  double get uptimeWeekScore;
  int get currentIndex;
  String get upperLabel;
  String get statsLabel;
  String get error;

  @JsonKey(ignore: true)
  $MinerStatsStateCopyWith<MinerStatsState> get copyWith;
}

/// @nodoc
abstract class $MinerStatsStateCopyWith<$Res> {
  factory $MinerStatsStateCopyWith(
          MinerStatsState value, $Res Function(MinerStatsState) then) =
      _$MinerStatsStateCopyWithImpl<$Res>;
  $Res call(
      {List<MinerStatsEntity> originList,
      List<MinerStatsEntity> originMonthlyList,
      List<MinerStatsEntity> originYearlyList,
      List<double> xDataList,
      List<String> xLabelList,
      List<int> yLabelList,
      bool showLoading,
      MinerStatsTimePeriod selectedTimePeriod,
      MinerStatsType selectedType,
      double uptimeWeekScore,
      int currentIndex,
      String upperLabel,
      String statsLabel,
      String error});
}

/// @nodoc
class _$MinerStatsStateCopyWithImpl<$Res>
    implements $MinerStatsStateCopyWith<$Res> {
  _$MinerStatsStateCopyWithImpl(this._value, this._then);

  final MinerStatsState _value;
  // ignore: unused_field
  final $Res Function(MinerStatsState) _then;

  @override
  $Res call({
    Object originList = freezed,
    Object originMonthlyList = freezed,
    Object originYearlyList = freezed,
    Object xDataList = freezed,
    Object xLabelList = freezed,
    Object yLabelList = freezed,
    Object showLoading = freezed,
    Object selectedTimePeriod = freezed,
    Object selectedType = freezed,
    Object uptimeWeekScore = freezed,
    Object currentIndex = freezed,
    Object upperLabel = freezed,
    Object statsLabel = freezed,
    Object error = freezed,
  }) {
    return _then(_value.copyWith(
      originList: originList == freezed
          ? _value.originList
          : originList as List<MinerStatsEntity>,
      originMonthlyList: originMonthlyList == freezed
          ? _value.originMonthlyList
          : originMonthlyList as List<MinerStatsEntity>,
      originYearlyList: originYearlyList == freezed
          ? _value.originYearlyList
          : originYearlyList as List<MinerStatsEntity>,
      xDataList:
          xDataList == freezed ? _value.xDataList : xDataList as List<double>,
      xLabelList: xLabelList == freezed
          ? _value.xLabelList
          : xLabelList as List<String>,
      yLabelList:
          yLabelList == freezed ? _value.yLabelList : yLabelList as List<int>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      selectedTimePeriod: selectedTimePeriod == freezed
          ? _value.selectedTimePeriod
          : selectedTimePeriod as MinerStatsTimePeriod,
      selectedType: selectedType == freezed
          ? _value.selectedType
          : selectedType as MinerStatsType,
      uptimeWeekScore: uptimeWeekScore == freezed
          ? _value.uptimeWeekScore
          : uptimeWeekScore as double,
      currentIndex:
          currentIndex == freezed ? _value.currentIndex : currentIndex as int,
      upperLabel:
          upperLabel == freezed ? _value.upperLabel : upperLabel as String,
      statsLabel:
          statsLabel == freezed ? _value.statsLabel : statsLabel as String,
      error: error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
abstract class _$MinerStatsStateCopyWith<$Res>
    implements $MinerStatsStateCopyWith<$Res> {
  factory _$MinerStatsStateCopyWith(
          _MinerStatsState value, $Res Function(_MinerStatsState) then) =
      __$MinerStatsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<MinerStatsEntity> originList,
      List<MinerStatsEntity> originMonthlyList,
      List<MinerStatsEntity> originYearlyList,
      List<double> xDataList,
      List<String> xLabelList,
      List<int> yLabelList,
      bool showLoading,
      MinerStatsTimePeriod selectedTimePeriod,
      MinerStatsType selectedType,
      double uptimeWeekScore,
      int currentIndex,
      String upperLabel,
      String statsLabel,
      String error});
}

/// @nodoc
class __$MinerStatsStateCopyWithImpl<$Res>
    extends _$MinerStatsStateCopyWithImpl<$Res>
    implements _$MinerStatsStateCopyWith<$Res> {
  __$MinerStatsStateCopyWithImpl(
      _MinerStatsState _value, $Res Function(_MinerStatsState) _then)
      : super(_value, (v) => _then(v as _MinerStatsState));

  @override
  _MinerStatsState get _value => super._value as _MinerStatsState;

  @override
  $Res call({
    Object originList = freezed,
    Object originMonthlyList = freezed,
    Object originYearlyList = freezed,
    Object xDataList = freezed,
    Object xLabelList = freezed,
    Object yLabelList = freezed,
    Object showLoading = freezed,
    Object selectedTimePeriod = freezed,
    Object selectedType = freezed,
    Object uptimeWeekScore = freezed,
    Object currentIndex = freezed,
    Object upperLabel = freezed,
    Object statsLabel = freezed,
    Object error = freezed,
  }) {
    return _then(_MinerStatsState(
      originList: originList == freezed
          ? _value.originList
          : originList as List<MinerStatsEntity>,
      originMonthlyList: originMonthlyList == freezed
          ? _value.originMonthlyList
          : originMonthlyList as List<MinerStatsEntity>,
      originYearlyList: originYearlyList == freezed
          ? _value.originYearlyList
          : originYearlyList as List<MinerStatsEntity>,
      xDataList:
          xDataList == freezed ? _value.xDataList : xDataList as List<double>,
      xLabelList: xLabelList == freezed
          ? _value.xLabelList
          : xLabelList as List<String>,
      yLabelList:
          yLabelList == freezed ? _value.yLabelList : yLabelList as List<int>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      selectedTimePeriod: selectedTimePeriod == freezed
          ? _value.selectedTimePeriod
          : selectedTimePeriod as MinerStatsTimePeriod,
      selectedType: selectedType == freezed
          ? _value.selectedType
          : selectedType as MinerStatsType,
      uptimeWeekScore: uptimeWeekScore == freezed
          ? _value.uptimeWeekScore
          : uptimeWeekScore as double,
      currentIndex:
          currentIndex == freezed ? _value.currentIndex : currentIndex as int,
      upperLabel:
          upperLabel == freezed ? _value.upperLabel : upperLabel as String,
      statsLabel:
          statsLabel == freezed ? _value.statsLabel : statsLabel as String,
      error: error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
class _$_MinerStatsState implements _MinerStatsState {
  _$_MinerStatsState(
      {this.originList = const [],
      this.originMonthlyList = const [],
      this.originYearlyList = const [],
      this.xDataList = const [],
      this.xLabelList = const [],
      this.yLabelList = const [],
      this.showLoading = false,
      this.selectedTimePeriod = MinerStatsTimePeriod.week,
      this.selectedType = MinerStatsType.uptime,
      this.uptimeWeekScore = 0,
      this.currentIndex = -1,
      this.upperLabel = '',
      this.statsLabel = '',
      this.error})
      : assert(originList != null),
        assert(originMonthlyList != null),
        assert(originYearlyList != null),
        assert(xDataList != null),
        assert(xLabelList != null),
        assert(yLabelList != null),
        assert(showLoading != null),
        assert(selectedTimePeriod != null),
        assert(selectedType != null),
        assert(uptimeWeekScore != null),
        assert(currentIndex != null),
        assert(upperLabel != null),
        assert(statsLabel != null);

  @JsonKey(defaultValue: const [])
  @override
  final List<MinerStatsEntity> originList;
  @JsonKey(defaultValue: const [])
  @override
  final List<MinerStatsEntity> originMonthlyList;
  @JsonKey(defaultValue: const [])
  @override
  final List<MinerStatsEntity> originYearlyList;
  @JsonKey(defaultValue: const [])
  @override
  final List<double> xDataList;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> xLabelList;
  @JsonKey(defaultValue: const [])
  @override
  final List<int> yLabelList;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;
  @JsonKey(defaultValue: MinerStatsTimePeriod.week)
  @override
  final MinerStatsTimePeriod selectedTimePeriod;
  @JsonKey(defaultValue: MinerStatsType.uptime)
  @override
  final MinerStatsType selectedType;
  @JsonKey(defaultValue: 0)
  @override
  final double uptimeWeekScore;
  @JsonKey(defaultValue: -1)
  @override
  final int currentIndex;
  @JsonKey(defaultValue: '')
  @override
  final String upperLabel;
  @JsonKey(defaultValue: '')
  @override
  final String statsLabel;
  @override
  final String error;

  @override
  String toString() {
    return 'MinerStatsState(originList: $originList, originMonthlyList: $originMonthlyList, originYearlyList: $originYearlyList, xDataList: $xDataList, xLabelList: $xLabelList, yLabelList: $yLabelList, showLoading: $showLoading, selectedTimePeriod: $selectedTimePeriod, selectedType: $selectedType, uptimeWeekScore: $uptimeWeekScore, currentIndex: $currentIndex, upperLabel: $upperLabel, statsLabel: $statsLabel, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MinerStatsState &&
            (identical(other.originList, originList) ||
                const DeepCollectionEquality()
                    .equals(other.originList, originList)) &&
            (identical(other.originMonthlyList, originMonthlyList) ||
                const DeepCollectionEquality()
                    .equals(other.originMonthlyList, originMonthlyList)) &&
            (identical(other.originYearlyList, originYearlyList) ||
                const DeepCollectionEquality()
                    .equals(other.originYearlyList, originYearlyList)) &&
            (identical(other.xDataList, xDataList) ||
                const DeepCollectionEquality()
                    .equals(other.xDataList, xDataList)) &&
            (identical(other.xLabelList, xLabelList) ||
                const DeepCollectionEquality()
                    .equals(other.xLabelList, xLabelList)) &&
            (identical(other.yLabelList, yLabelList) ||
                const DeepCollectionEquality()
                    .equals(other.yLabelList, yLabelList)) &&
            (identical(other.showLoading, showLoading) ||
                const DeepCollectionEquality()
                    .equals(other.showLoading, showLoading)) &&
            (identical(other.selectedTimePeriod, selectedTimePeriod) ||
                const DeepCollectionEquality()
                    .equals(other.selectedTimePeriod, selectedTimePeriod)) &&
            (identical(other.selectedType, selectedType) ||
                const DeepCollectionEquality()
                    .equals(other.selectedType, selectedType)) &&
            (identical(other.uptimeWeekScore, uptimeWeekScore) ||
                const DeepCollectionEquality()
                    .equals(other.uptimeWeekScore, uptimeWeekScore)) &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)) &&
            (identical(other.upperLabel, upperLabel) ||
                const DeepCollectionEquality()
                    .equals(other.upperLabel, upperLabel)) &&
            (identical(other.statsLabel, statsLabel) ||
                const DeepCollectionEquality()
                    .equals(other.statsLabel, statsLabel)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(originList) ^
      const DeepCollectionEquality().hash(originMonthlyList) ^
      const DeepCollectionEquality().hash(originYearlyList) ^
      const DeepCollectionEquality().hash(xDataList) ^
      const DeepCollectionEquality().hash(xLabelList) ^
      const DeepCollectionEquality().hash(yLabelList) ^
      const DeepCollectionEquality().hash(showLoading) ^
      const DeepCollectionEquality().hash(selectedTimePeriod) ^
      const DeepCollectionEquality().hash(selectedType) ^
      const DeepCollectionEquality().hash(uptimeWeekScore) ^
      const DeepCollectionEquality().hash(currentIndex) ^
      const DeepCollectionEquality().hash(upperLabel) ^
      const DeepCollectionEquality().hash(statsLabel) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$MinerStatsStateCopyWith<_MinerStatsState> get copyWith =>
      __$MinerStatsStateCopyWithImpl<_MinerStatsState>(this, _$identity);
}

abstract class _MinerStatsState implements MinerStatsState {
  factory _MinerStatsState(
      {List<MinerStatsEntity> originList,
      List<MinerStatsEntity> originMonthlyList,
      List<MinerStatsEntity> originYearlyList,
      List<double> xDataList,
      List<String> xLabelList,
      List<int> yLabelList,
      bool showLoading,
      MinerStatsTimePeriod selectedTimePeriod,
      MinerStatsType selectedType,
      double uptimeWeekScore,
      int currentIndex,
      String upperLabel,
      String statsLabel,
      String error}) = _$_MinerStatsState;

  @override
  List<MinerStatsEntity> get originList;
  @override
  List<MinerStatsEntity> get originMonthlyList;
  @override
  List<MinerStatsEntity> get originYearlyList;
  @override
  List<double> get xDataList;
  @override
  List<String> get xLabelList;
  @override
  List<int> get yLabelList;
  @override
  bool get showLoading;
  @override
  MinerStatsTimePeriod get selectedTimePeriod;
  @override
  MinerStatsType get selectedType;
  @override
  double get uptimeWeekScore;
  @override
  int get currentIndex;
  @override
  String get upperLabel;
  @override
  String get statsLabel;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$MinerStatsStateCopyWith<_MinerStatsState> get copyWith;
}
