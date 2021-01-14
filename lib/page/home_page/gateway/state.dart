import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
abstract class GatewayState with _$GatewayState {
  factory GatewayState({
    @Default(Wrap.pending()) Wrap<int> gatewaysTotal,
    @Default(Wrap.pending()) Wrap<List<GatewayItem>> gateways,
  }) = _GatewayState;
}

@freezed
abstract class GatewayItem with _$GatewayItem {
  factory GatewayItem({
    @required String id,
    @required String name,
    @required String description,
    @required Map location, // RETHINK.TODO - remove map
    @required @JsonKey(name: 'organizationID') String organizationId,
    @required bool discoveryEnabled,
    @required @JsonKey(name: 'networkServerID') String networkServerId,
    @required String gatewayProfileId,
    @required List boards, // RETHINK.TODO - remove dynamic
    @required String createdAt,
    @required String updatedAt,
    @required String firstSeenAt,
    @required String lastSeenAt,
    @required String model,
    @required String osversion,
  }) = _GatewayItem;

  factory GatewayItem.fromJson(Map<String, dynamic> json) =>
      _$GatewayItemFromJson(json);
}
