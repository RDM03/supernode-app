// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SupernodeStateTearOff {
  const _$SupernodeStateTearOff();

// ignore: unused_element
  _SupernodeState call(
      {SuperNodeBean currentNode,
      String userId,
      String username,
      String orgId}) {
    return _SupernodeState(
      currentNode: currentNode,
      userId: userId,
      username: username,
      orgId: orgId,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeState = _$SupernodeStateTearOff();

/// @nodoc
mixin _$SupernodeState {
  SuperNodeBean get currentNode;
  String get userId;
  String get username;
  String get orgId;

  $SupernodeStateCopyWith<SupernodeState> get copyWith;
}

/// @nodoc
abstract class $SupernodeStateCopyWith<$Res> {
  factory $SupernodeStateCopyWith(
          SupernodeState value, $Res Function(SupernodeState) then) =
      _$SupernodeStateCopyWithImpl<$Res>;
  $Res call(
      {SuperNodeBean currentNode,
      String userId,
      String username,
      String orgId});
}

/// @nodoc
class _$SupernodeStateCopyWithImpl<$Res>
    implements $SupernodeStateCopyWith<$Res> {
  _$SupernodeStateCopyWithImpl(this._value, this._then);

  final SupernodeState _value;
  // ignore: unused_field
  final $Res Function(SupernodeState) _then;

  @override
  $Res call({
    Object currentNode = freezed,
    Object userId = freezed,
    Object username = freezed,
    Object orgId = freezed,
  }) {
    return _then(_value.copyWith(
      currentNode: currentNode == freezed
          ? _value.currentNode
          : currentNode as SuperNodeBean,
      userId: userId == freezed ? _value.userId : userId as String,
      username: username == freezed ? _value.username : username as String,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }
}

/// @nodoc
abstract class _$SupernodeStateCopyWith<$Res>
    implements $SupernodeStateCopyWith<$Res> {
  factory _$SupernodeStateCopyWith(
          _SupernodeState value, $Res Function(_SupernodeState) then) =
      __$SupernodeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {SuperNodeBean currentNode,
      String userId,
      String username,
      String orgId});
}

/// @nodoc
class __$SupernodeStateCopyWithImpl<$Res>
    extends _$SupernodeStateCopyWithImpl<$Res>
    implements _$SupernodeStateCopyWith<$Res> {
  __$SupernodeStateCopyWithImpl(
      _SupernodeState _value, $Res Function(_SupernodeState) _then)
      : super(_value, (v) => _then(v as _SupernodeState));

  @override
  _SupernodeState get _value => super._value as _SupernodeState;

  @override
  $Res call({
    Object currentNode = freezed,
    Object userId = freezed,
    Object username = freezed,
    Object orgId = freezed,
  }) {
    return _then(_SupernodeState(
      currentNode: currentNode == freezed
          ? _value.currentNode
          : currentNode as SuperNodeBean,
      userId: userId == freezed ? _value.userId : userId as String,
      username: username == freezed ? _value.username : username as String,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }
}

/// @nodoc
class _$_SupernodeState
    with DiagnosticableTreeMixin
    implements _SupernodeState {
  _$_SupernodeState({this.currentNode, this.userId, this.username, this.orgId});

  @override
  final SuperNodeBean currentNode;
  @override
  final String userId;
  @override
  final String username;
  @override
  final String orgId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeState(currentNode: $currentNode, userId: $userId, username: $username, orgId: $orgId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeState'))
      ..add(DiagnosticsProperty('currentNode', currentNode))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('orgId', orgId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeState &&
            (identical(other.currentNode, currentNode) ||
                const DeepCollectionEquality()
                    .equals(other.currentNode, currentNode)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.orgId, orgId) ||
                const DeepCollectionEquality().equals(other.orgId, orgId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentNode) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(orgId);

  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith =>
      __$SupernodeStateCopyWithImpl<_SupernodeState>(this, _$identity);
}

abstract class _SupernodeState implements SupernodeState {
  factory _SupernodeState(
      {SuperNodeBean currentNode,
      String userId,
      String username,
      String orgId}) = _$_SupernodeState;

  @override
  SuperNodeBean get currentNode;
  @override
  String get userId;
  @override
  String get username;
  @override
  String get orgId;
  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith;
}

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call({SupernodeState supernode, bool isDemo = false}) {
    return _AppState(
      supernode: supernode,
      isDemo: isDemo,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  SupernodeState get supernode;
  bool get isDemo;

  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call({SupernodeState supernode, bool isDemo});

  $SupernodeStateCopyWith<$Res> get supernode;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object supernode = freezed,
    Object isDemo = freezed,
  }) {
    return _then(_value.copyWith(
      supernode:
          supernode == freezed ? _value.supernode : supernode as SupernodeState,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
    ));
  }

  @override
  $SupernodeStateCopyWith<$Res> get supernode {
    if (_value.supernode == null) {
      return null;
    }
    return $SupernodeStateCopyWith<$Res>(_value.supernode, (value) {
      return _then(_value.copyWith(supernode: value));
    });
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call({SupernodeState supernode, bool isDemo});

  @override
  $SupernodeStateCopyWith<$Res> get supernode;
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(_AppState _value, $Res Function(_AppState) _then)
      : super(_value, (v) => _then(v as _AppState));

  @override
  _AppState get _value => super._value as _AppState;

  @override
  $Res call({
    Object supernode = freezed,
    Object isDemo = freezed,
  }) {
    return _then(_AppState(
      supernode:
          supernode == freezed ? _value.supernode : supernode as SupernodeState,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
    ));
  }
}

/// @nodoc
class _$_AppState with DiagnosticableTreeMixin implements _AppState {
  _$_AppState({this.supernode, this.isDemo = false}) : assert(isDemo != null);

  @override
  final SupernodeState supernode;
  @JsonKey(defaultValue: false)
  @override
  final bool isDemo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(supernode: $supernode, isDemo: $isDemo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('supernode', supernode))
      ..add(DiagnosticsProperty('isDemo', isDemo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.supernode, supernode) ||
                const DeepCollectionEquality()
                    .equals(other.supernode, supernode)) &&
            (identical(other.isDemo, isDemo) ||
                const DeepCollectionEquality().equals(other.isDemo, isDemo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(supernode) ^
      const DeepCollectionEquality().hash(isDemo);

  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState({SupernodeState supernode, bool isDemo}) = _$_AppState;

  @override
  SupernodeState get supernode;
  @override
  bool get isDemo;
  @override
  _$AppStateCopyWith<_AppState> get copyWith;
}
