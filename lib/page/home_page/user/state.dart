import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  factory UserState({
    @required String username,
    List<dynamic>
        geojsonList, // RETHINK.TODO If anyone can remove dynamic, please do it
    @Default(Wrap.pending()) Wrap<double> balance,
    @Default(Wrap.pending()) Wrap<double> stakedAmount,
    @Default(Wrap.pending()) Wrap<double> lockedAmount,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenue,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> devicesRevenue,
    @Default(Wrap.pending()) Wrap<double> devicesRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> totalRevenue,
    @Default(Wrap.pending()) Wrap<int> devicesTotal,
  }) = _UserState;
}
