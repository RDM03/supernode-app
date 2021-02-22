import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class SupernodeUserState with _$SupernodeUserState {
  factory SupernodeUserState({
    @required String username,
    @nullable String email,
    List<dynamic>
        geojsonList, // RETHINK.TODO If anyone can remove dynamic, please do it
    @Default(false) bool locationPermissionsGranted,
    @nullable ExternalUser weChatUser,
    @nullable ExternalUser shopifyUser,
    @Default(Wrap.pending()) Wrap<double> balance,
    @Default(Wrap.pending()) Wrap<double> stakedAmount,
    @Default(Wrap.pending()) Wrap<double> lockedAmount,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenue,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> devicesRevenue,
    @Default(Wrap.pending()) Wrap<double> devicesRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> totalRevenue,
    @Default(Wrap.pending()) Wrap<int> devicesTotal,
    @Default(Wrap.pending()) Wrap<bool> isAdmin,
    @Default(Wrap.pending()) Wrap<List<UserOrganization>> organizations,
  }) = _SupernodeUserState;
}
