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
      List<double> xDataList = const [],
      List<String> xLabelList = const [],
      List<double> yLabelList = const [],
      bool showLoading = false,
      MinerStatsTime selectedTime = MinerStatsTime.week,
      MinerStatsType selectedType = MinerStatsType.uptime,
      double uptimeWeekScore = 0,
      String error}) {
    return _MinerStatsState(
      originList: originList,
      xDataList: xDataList,
      xLabelList: xLabelList,
      yLabelList: yLabelList,
      showLoading: showLoading,
      selectedTime: selectedTime,
      selectedType: selectedType,
      uptimeWeekScore: uptimeWeekScore,
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
  List<double> get xDataList;
  List<String> get xLabelList;
  List<double> get yLabelList;
  bool get showLoading;
  MinerStatsTime get selectedTime;
  MinerStatsType get selectedType;
  double get uptimeWeekScore;
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
      List<double> xDataList,
      List<String> xLabelList,
      List<double> yLabelList,
      bool showLoading,
      MinerStatsTime selectedTime,
      MinerStatsType selectedType,
      double uptimeWeekScore,
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
    Object xDataList = freezed,
    Object xLabelList = freezed,
    Object yLabelList = freezed,
    Object showLoading = freezed,
    Object selectedTime = freezed,
    Object selectedType = freezed,
    Object uptimeWeekScore = freezed,
    Object error = freezed,
  }) {
    return _then(_value.copyWith(
      originList: originList == freezed
          ? _value.originList
          : originList as List<MinerStatsEntity>,
      xDataList:
          xDataList == freezed ? _value.xDataList : xDataList as List<double>,
      xLabelList: xLabelList == freezed
          ? _value.xLabelList
          : xLabelList as List<String>,
      yLabelList: yLabelList == freezed
          ? _value.yLabelList
          : yLabelList as List<double>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      selectedTime: selectedTime == freezed
          ? _value.selectedTime
          : selectedTime as MinerStatsTime,
      selectedType: selectedType == freezed
          ? _value.selectedType
          : selectedType as MinerStatsType,
      uptimeWeekScore: uptimeWeekScore == freezed
          ? _value.uptimeWeekScore
          : uptimeWeekScore as double,
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
      List<double> xDataList,
      List<String> xLabelList,
      List<double> yLabelList,
      bool showLoading,
      MinerStatsTime selectedTime,
      MinerStatsType selectedType,
      double uptimeWeekScore,
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
    Object xDataList = freezed,
    Object xLabelList = freezed,
    Object yLabelList = freezed,
    Object showLoading = freezed,
    Object selectedTime = freezed,
    Object selectedType = freezed,
    Object uptimeWeekScore = freezed,
    Object error = freezed,
  }) {
    return _then(_MinerStatsState(
      originList: originList == freezed
          ? _value.originList
          : originList as List<MinerStatsEntity>,
      xDataList:
          xDataList == freezed ? _value.xDataList : xDataList as List<double>,
      xLabelList: xLabelList == freezed
          ? _value.xLabelList
          : xLabelList as List<String>,
      yLabelList: yLabelList == freezed
          ? _value.yLabelList
          : yLabelList as List<double>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      selectedTime: selectedTime == freezed
          ? _value.selectedTime
          : selectedTime as MinerStatsTime,
      selectedType: selectedType == freezed
          ? _value.selectedType
          : selectedType as MinerStatsType,
      uptimeWeekScore: uptimeWeekScore == freezed
          ? _value.uptimeWeekScore
          : uptimeWeekScore as double,
      error: error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
class _$_MinerStatsState implements _MinerStatsState {
  _$_MinerStatsState(
      {this.originList = const [],
      this.xDataList = const [],
      this.xLabelList = const [],
      this.yLabelList = const [],
      this.showLoading = false,
      this.selectedTime = MinerStatsTime.week,
      this.selectedType = MinerStatsType.uptime,
      this.uptimeWeekScore = 0,
      this.error})
      : assert(originList != null),
        assert(xDataList != null),
        assert(xLabelList != null),
        assert(yLabelList != null),
        assert(showLoading != null),
        assert(selectedTime != null),
        assert(selectedType != null),
        assert(uptimeWeekScore != null);

  @JsonKey(defaultValue: const [])
  @override
  final List<MinerStatsEntity> originList;
  @JsonKey(defaultValue: const [])
  @override
  final List<double> xDataList;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> xLabelList;
  @JsonKey(defaultValue: const [])
  @override
  final List<double> yLabelList;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;
  @JsonKey(defaultValue: MinerStatsTime.week)
  @override
  final MinerStatsTime selectedTime;
  @JsonKey(defaultValue: MinerStatsType.uptime)
  @override
  final MinerStatsType selectedType;
  @JsonKey(defaultValue: 0)
  @override
  final double uptimeWeekScore;
  @override
  final String error;

  @override
  String toString() {
    return 'MinerStatsState(originList: $originList, xDataList: $xDataList, xLabelList: $xLabelList, yLabelList: $yLabelList, showLoading: $showLoading, selectedTime: $selectedTime, selectedType: $selectedType, uptimeWeekScore: $uptimeWeekScore, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MinerStatsState &&
            (identical(other.originList, originList) ||
                const DeepCollectionEquality()
                    .equals(other.originList, originList)) &&
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
            (identical(other.selectedTime, selectedTime) ||
                const DeepCollectionEquality()
                    .equals(other.selectedTime, selectedTime)) &&
            (identical(other.selectedType, selectedType) ||
                const DeepCollectionEquality()
                    .equals(other.selectedType, selectedType)) &&
            (identical(other.uptimeWeekScore, uptimeWeekScore) ||
                const DeepCollectionEquality()
                    .equals(other.uptimeWeekScore, uptimeWeekScore)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(originList) ^
      const DeepCollectionEquality().hash(xDataList) ^
      const DeepCollectionEquality().hash(xLabelList) ^
      const DeepCollectionEquality().hash(yLabelList) ^
      const DeepCollectionEquality().hash(showLoading) ^
      const DeepCollectionEquality().hash(selectedTime) ^
      const DeepCollectionEquality().hash(selectedType) ^
      const DeepCollectionEquality().hash(uptimeWeekScore) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$MinerStatsStateCopyWith<_MinerStatsState> get copyWith =>
      __$MinerStatsStateCopyWithImpl<_MinerStatsState>(this, _$identity);
}

abstract class _MinerStatsState implements MinerStatsState {
  factory _MinerStatsState(
      {List<MinerStatsEntity> originList,
      List<double> xDataList,
      List<String> xLabelList,
      List<double> yLabelList,
      bool showLoading,
      MinerStatsTime selectedTime,
      MinerStatsType selectedType,
      double uptimeWeekScore,
      String error}) = _$_MinerStatsState;

  @override
  List<MinerStatsEntity> get originList;
  @override
  List<double> get xDataList;
  @override
  List<String> get xLabelList;
  @override
  List<double> get yLabelList;
  @override
  bool get showLoading;
  @override
  MinerStatsTime get selectedTime;
  @override
  MinerStatsType get selectedType;
  @override
  double get uptimeWeekScore;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$MinerStatsStateCopyWith<_MinerStatsState> get copyWith;
}
