// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GatewayStateTearOff {
  const _$GatewayStateTearOff();

// ignore: unused_element
  _GatewayState call(
      {Wrap<int> gatewaysTotal = const Wrap.pending(),
      Wrap<List<GatewayItem>> gateways = const Wrap.pending()}) {
    return _GatewayState(
      gatewaysTotal: gatewaysTotal,
      gateways: gateways,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GatewayState = _$GatewayStateTearOff();

/// @nodoc
mixin _$GatewayState {
  Wrap<int> get gatewaysTotal;
  Wrap<List<GatewayItem>> get gateways;

  $GatewayStateCopyWith<GatewayState> get copyWith;
}

/// @nodoc
abstract class $GatewayStateCopyWith<$Res> {
  factory $GatewayStateCopyWith(
          GatewayState value, $Res Function(GatewayState) then) =
      _$GatewayStateCopyWithImpl<$Res>;
  $Res call({Wrap<int> gatewaysTotal, Wrap<List<GatewayItem>> gateways});
}

/// @nodoc
class _$GatewayStateCopyWithImpl<$Res> implements $GatewayStateCopyWith<$Res> {
  _$GatewayStateCopyWithImpl(this._value, this._then);

  final GatewayState _value;
  // ignore: unused_field
  final $Res Function(GatewayState) _then;

  @override
  $Res call({
    Object gatewaysTotal = freezed,
    Object gateways = freezed,
  }) {
    return _then(_value.copyWith(
      gatewaysTotal: gatewaysTotal == freezed
          ? _value.gatewaysTotal
          : gatewaysTotal as Wrap<int>,
      gateways: gateways == freezed
          ? _value.gateways
          : gateways as Wrap<List<GatewayItem>>,
    ));
  }
}

/// @nodoc
abstract class _$GatewayStateCopyWith<$Res>
    implements $GatewayStateCopyWith<$Res> {
  factory _$GatewayStateCopyWith(
          _GatewayState value, $Res Function(_GatewayState) then) =
      __$GatewayStateCopyWithImpl<$Res>;
  @override
  $Res call({Wrap<int> gatewaysTotal, Wrap<List<GatewayItem>> gateways});
}

/// @nodoc
class __$GatewayStateCopyWithImpl<$Res> extends _$GatewayStateCopyWithImpl<$Res>
    implements _$GatewayStateCopyWith<$Res> {
  __$GatewayStateCopyWithImpl(
      _GatewayState _value, $Res Function(_GatewayState) _then)
      : super(_value, (v) => _then(v as _GatewayState));

  @override
  _GatewayState get _value => super._value as _GatewayState;

  @override
  $Res call({
    Object gatewaysTotal = freezed,
    Object gateways = freezed,
  }) {
    return _then(_GatewayState(
      gatewaysTotal: gatewaysTotal == freezed
          ? _value.gatewaysTotal
          : gatewaysTotal as Wrap<int>,
      gateways: gateways == freezed
          ? _value.gateways
          : gateways as Wrap<List<GatewayItem>>,
    ));
  }
}

/// @nodoc
class _$_GatewayState with DiagnosticableTreeMixin implements _GatewayState {
  _$_GatewayState(
      {this.gatewaysTotal = const Wrap.pending(),
      this.gateways = const Wrap.pending()})
      : assert(gatewaysTotal != null),
        assert(gateways != null);

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<int> gatewaysTotal;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<GatewayItem>> gateways;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GatewayState(gatewaysTotal: $gatewaysTotal, gateways: $gateways)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GatewayState'))
      ..add(DiagnosticsProperty('gatewaysTotal', gatewaysTotal))
      ..add(DiagnosticsProperty('gateways', gateways));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GatewayState &&
            (identical(other.gatewaysTotal, gatewaysTotal) ||
                const DeepCollectionEquality()
                    .equals(other.gatewaysTotal, gatewaysTotal)) &&
            (identical(other.gateways, gateways) ||
                const DeepCollectionEquality()
                    .equals(other.gateways, gateways)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(gatewaysTotal) ^
      const DeepCollectionEquality().hash(gateways);

  @override
  _$GatewayStateCopyWith<_GatewayState> get copyWith =>
      __$GatewayStateCopyWithImpl<_GatewayState>(this, _$identity);
}

abstract class _GatewayState implements GatewayState {
  factory _GatewayState(
      {Wrap<int> gatewaysTotal,
      Wrap<List<GatewayItem>> gateways}) = _$_GatewayState;

  @override
  Wrap<int> get gatewaysTotal;
  @override
  Wrap<List<GatewayItem>> get gateways;
  @override
  _$GatewayStateCopyWith<_GatewayState> get copyWith;
}

GatewayItem _$GatewayItemFromJson(Map<String, dynamic> json) {
  return _GatewayItem.fromJson(json);
}

/// @nodoc
class _$GatewayItemTearOff {
  const _$GatewayItemTearOff();

// ignore: unused_element
  _GatewayItem call(
      {@required String id,
      @required String name,
      @required String description,
      @required Map<dynamic, dynamic> location,
      @required @JsonKey(name: 'organizationID') String organizationId,
      @required bool discoveryEnabled,
      @required @JsonKey(name: 'networkServerID') String networkServerId,
      @required String gatewayProfileId,
      @required List<dynamic> boards,
      @required String createdAt,
      @required String updatedAt,
      @required String firstSeenAt,
      @required String lastSeenAt,
      @required String model,
      @required String osversion}) {
    return _GatewayItem(
      id: id,
      name: name,
      description: description,
      location: location,
      organizationId: organizationId,
      discoveryEnabled: discoveryEnabled,
      networkServerId: networkServerId,
      gatewayProfileId: gatewayProfileId,
      boards: boards,
      createdAt: createdAt,
      updatedAt: updatedAt,
      firstSeenAt: firstSeenAt,
      lastSeenAt: lastSeenAt,
      model: model,
      osversion: osversion,
    );
  }

// ignore: unused_element
  GatewayItem fromJson(Map<String, Object> json) {
    return GatewayItem.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $GatewayItem = _$GatewayItemTearOff();

/// @nodoc
mixin _$GatewayItem {
  String get id;
  String get name;
  String get description;
  Map<dynamic, dynamic> get location; // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  String get organizationId;
  bool get discoveryEnabled;
  @JsonKey(name: 'networkServerID')
  String get networkServerId;
  String get gatewayProfileId;
  List<dynamic> get boards; // RETHINK.TODO - remove dynamic
  String get createdAt;
  String get updatedAt;
  String get firstSeenAt;
  String get lastSeenAt;
  String get model;
  String get osversion;

  Map<String, dynamic> toJson();
  $GatewayItemCopyWith<GatewayItem> get copyWith;
}

/// @nodoc
abstract class $GatewayItemCopyWith<$Res> {
  factory $GatewayItemCopyWith(
          GatewayItem value, $Res Function(GatewayItem) then) =
      _$GatewayItemCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String description,
      Map<dynamic, dynamic> location,
      @JsonKey(name: 'organizationID') String organizationId,
      bool discoveryEnabled,
      @JsonKey(name: 'networkServerID') String networkServerId,
      String gatewayProfileId,
      List<dynamic> boards,
      String createdAt,
      String updatedAt,
      String firstSeenAt,
      String lastSeenAt,
      String model,
      String osversion});
}

/// @nodoc
class _$GatewayItemCopyWithImpl<$Res> implements $GatewayItemCopyWith<$Res> {
  _$GatewayItemCopyWithImpl(this._value, this._then);

  final GatewayItem _value;
  // ignore: unused_field
  final $Res Function(GatewayItem) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object location = freezed,
    Object organizationId = freezed,
    Object discoveryEnabled = freezed,
    Object networkServerId = freezed,
    Object gatewayProfileId = freezed,
    Object boards = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object firstSeenAt = freezed,
    Object lastSeenAt = freezed,
    Object model = freezed,
    Object osversion = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      location: location == freezed
          ? _value.location
          : location as Map<dynamic, dynamic>,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId as String,
      discoveryEnabled: discoveryEnabled == freezed
          ? _value.discoveryEnabled
          : discoveryEnabled as bool,
      networkServerId: networkServerId == freezed
          ? _value.networkServerId
          : networkServerId as String,
      gatewayProfileId: gatewayProfileId == freezed
          ? _value.gatewayProfileId
          : gatewayProfileId as String,
      boards: boards == freezed ? _value.boards : boards as List<dynamic>,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      firstSeenAt:
          firstSeenAt == freezed ? _value.firstSeenAt : firstSeenAt as String,
      lastSeenAt:
          lastSeenAt == freezed ? _value.lastSeenAt : lastSeenAt as String,
      model: model == freezed ? _value.model : model as String,
      osversion: osversion == freezed ? _value.osversion : osversion as String,
    ));
  }
}

/// @nodoc
abstract class _$GatewayItemCopyWith<$Res>
    implements $GatewayItemCopyWith<$Res> {
  factory _$GatewayItemCopyWith(
          _GatewayItem value, $Res Function(_GatewayItem) then) =
      __$GatewayItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String description,
      Map<dynamic, dynamic> location,
      @JsonKey(name: 'organizationID') String organizationId,
      bool discoveryEnabled,
      @JsonKey(name: 'networkServerID') String networkServerId,
      String gatewayProfileId,
      List<dynamic> boards,
      String createdAt,
      String updatedAt,
      String firstSeenAt,
      String lastSeenAt,
      String model,
      String osversion});
}

/// @nodoc
class __$GatewayItemCopyWithImpl<$Res> extends _$GatewayItemCopyWithImpl<$Res>
    implements _$GatewayItemCopyWith<$Res> {
  __$GatewayItemCopyWithImpl(
      _GatewayItem _value, $Res Function(_GatewayItem) _then)
      : super(_value, (v) => _then(v as _GatewayItem));

  @override
  _GatewayItem get _value => super._value as _GatewayItem;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object location = freezed,
    Object organizationId = freezed,
    Object discoveryEnabled = freezed,
    Object networkServerId = freezed,
    Object gatewayProfileId = freezed,
    Object boards = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object firstSeenAt = freezed,
    Object lastSeenAt = freezed,
    Object model = freezed,
    Object osversion = freezed,
  }) {
    return _then(_GatewayItem(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      location: location == freezed
          ? _value.location
          : location as Map<dynamic, dynamic>,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId as String,
      discoveryEnabled: discoveryEnabled == freezed
          ? _value.discoveryEnabled
          : discoveryEnabled as bool,
      networkServerId: networkServerId == freezed
          ? _value.networkServerId
          : networkServerId as String,
      gatewayProfileId: gatewayProfileId == freezed
          ? _value.gatewayProfileId
          : gatewayProfileId as String,
      boards: boards == freezed ? _value.boards : boards as List<dynamic>,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      firstSeenAt:
          firstSeenAt == freezed ? _value.firstSeenAt : firstSeenAt as String,
      lastSeenAt:
          lastSeenAt == freezed ? _value.lastSeenAt : lastSeenAt as String,
      model: model == freezed ? _value.model : model as String,
      osversion: osversion == freezed ? _value.osversion : osversion as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_GatewayItem with DiagnosticableTreeMixin implements _GatewayItem {
  _$_GatewayItem(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.location,
      @required @JsonKey(name: 'organizationID') this.organizationId,
      @required this.discoveryEnabled,
      @required @JsonKey(name: 'networkServerID') this.networkServerId,
      @required this.gatewayProfileId,
      @required this.boards,
      @required this.createdAt,
      @required this.updatedAt,
      @required this.firstSeenAt,
      @required this.lastSeenAt,
      @required this.model,
      @required this.osversion})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(location != null),
        assert(organizationId != null),
        assert(discoveryEnabled != null),
        assert(networkServerId != null),
        assert(gatewayProfileId != null),
        assert(boards != null),
        assert(createdAt != null),
        assert(updatedAt != null),
        assert(firstSeenAt != null),
        assert(lastSeenAt != null),
        assert(model != null),
        assert(osversion != null);

  factory _$_GatewayItem.fromJson(Map<String, dynamic> json) =>
      _$_$_GatewayItemFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final Map<dynamic, dynamic> location;
  @override // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  final String organizationId;
  @override
  final bool discoveryEnabled;
  @override
  @JsonKey(name: 'networkServerID')
  final String networkServerId;
  @override
  final String gatewayProfileId;
  @override
  final List<dynamic> boards;
  @override // RETHINK.TODO - remove dynamic
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String firstSeenAt;
  @override
  final String lastSeenAt;
  @override
  final String model;
  @override
  final String osversion;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GatewayItem(id: $id, name: $name, description: $description, location: $location, organizationId: $organizationId, discoveryEnabled: $discoveryEnabled, networkServerId: $networkServerId, gatewayProfileId: $gatewayProfileId, boards: $boards, createdAt: $createdAt, updatedAt: $updatedAt, firstSeenAt: $firstSeenAt, lastSeenAt: $lastSeenAt, model: $model, osversion: $osversion)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GatewayItem'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('organizationId', organizationId))
      ..add(DiagnosticsProperty('discoveryEnabled', discoveryEnabled))
      ..add(DiagnosticsProperty('networkServerId', networkServerId))
      ..add(DiagnosticsProperty('gatewayProfileId', gatewayProfileId))
      ..add(DiagnosticsProperty('boards', boards))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('firstSeenAt', firstSeenAt))
      ..add(DiagnosticsProperty('lastSeenAt', lastSeenAt))
      ..add(DiagnosticsProperty('model', model))
      ..add(DiagnosticsProperty('osversion', osversion));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GatewayItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.organizationId, organizationId) ||
                const DeepCollectionEquality()
                    .equals(other.organizationId, organizationId)) &&
            (identical(other.discoveryEnabled, discoveryEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.discoveryEnabled, discoveryEnabled)) &&
            (identical(other.networkServerId, networkServerId) ||
                const DeepCollectionEquality()
                    .equals(other.networkServerId, networkServerId)) &&
            (identical(other.gatewayProfileId, gatewayProfileId) ||
                const DeepCollectionEquality()
                    .equals(other.gatewayProfileId, gatewayProfileId)) &&
            (identical(other.boards, boards) ||
                const DeepCollectionEquality().equals(other.boards, boards)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.firstSeenAt, firstSeenAt) ||
                const DeepCollectionEquality()
                    .equals(other.firstSeenAt, firstSeenAt)) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastSeenAt, lastSeenAt)) &&
            (identical(other.model, model) ||
                const DeepCollectionEquality().equals(other.model, model)) &&
            (identical(other.osversion, osversion) ||
                const DeepCollectionEquality()
                    .equals(other.osversion, osversion)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(organizationId) ^
      const DeepCollectionEquality().hash(discoveryEnabled) ^
      const DeepCollectionEquality().hash(networkServerId) ^
      const DeepCollectionEquality().hash(gatewayProfileId) ^
      const DeepCollectionEquality().hash(boards) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(firstSeenAt) ^
      const DeepCollectionEquality().hash(lastSeenAt) ^
      const DeepCollectionEquality().hash(model) ^
      const DeepCollectionEquality().hash(osversion);

  @override
  _$GatewayItemCopyWith<_GatewayItem> get copyWith =>
      __$GatewayItemCopyWithImpl<_GatewayItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GatewayItemToJson(this);
  }
}

abstract class _GatewayItem implements GatewayItem {
  factory _GatewayItem(
      {@required String id,
      @required String name,
      @required String description,
      @required Map<dynamic, dynamic> location,
      @required @JsonKey(name: 'organizationID') String organizationId,
      @required bool discoveryEnabled,
      @required @JsonKey(name: 'networkServerID') String networkServerId,
      @required String gatewayProfileId,
      @required List<dynamic> boards,
      @required String createdAt,
      @required String updatedAt,
      @required String firstSeenAt,
      @required String lastSeenAt,
      @required String model,
      @required String osversion}) = _$_GatewayItem;

  factory _GatewayItem.fromJson(Map<String, dynamic> json) =
      _$_GatewayItem.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<dynamic, dynamic> get location;
  @override // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  String get organizationId;
  @override
  bool get discoveryEnabled;
  @override
  @JsonKey(name: 'networkServerID')
  String get networkServerId;
  @override
  String get gatewayProfileId;
  @override
  List<dynamic> get boards;
  @override // RETHINK.TODO - remove dynamic
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String get firstSeenAt;
  @override
  String get lastSeenAt;
  @override
  String get model;
  @override
  String get osversion;
  @override
  _$GatewayItemCopyWith<_GatewayItem> get copyWith;
}
