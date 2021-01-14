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
      {SupernodeUser user, Supernode selectedNode, String orgId}) {
    return _SupernodeState(
      user: user,
      selectedNode: selectedNode,
      orgId: orgId,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeState = _$SupernodeStateTearOff();

/// @nodoc
mixin _$SupernodeState {
  SupernodeUser get user;
  Supernode get selectedNode;
  String get orgId;

  $SupernodeStateCopyWith<SupernodeState> get copyWith;
}

/// @nodoc
abstract class $SupernodeStateCopyWith<$Res> {
  factory $SupernodeStateCopyWith(
          SupernodeState value, $Res Function(SupernodeState) then) =
      _$SupernodeStateCopyWithImpl<$Res>;
  $Res call({SupernodeUser user, Supernode selectedNode, String orgId});

  $SupernodeUserCopyWith<$Res> get user;
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
    Object user = freezed,
    Object selectedNode = freezed,
    Object orgId = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed ? _value.user : user as SupernodeUser,
      selectedNode: selectedNode == freezed
          ? _value.selectedNode
          : selectedNode as Supernode,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }

  @override
  $SupernodeUserCopyWith<$Res> get user {
    if (_value.user == null) {
      return null;
    }
    return $SupernodeUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$SupernodeStateCopyWith<$Res>
    implements $SupernodeStateCopyWith<$Res> {
  factory _$SupernodeStateCopyWith(
          _SupernodeState value, $Res Function(_SupernodeState) then) =
      __$SupernodeStateCopyWithImpl<$Res>;
  @override
  $Res call({SupernodeUser user, Supernode selectedNode, String orgId});

  @override
  $SupernodeUserCopyWith<$Res> get user;
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
    Object user = freezed,
    Object selectedNode = freezed,
    Object orgId = freezed,
  }) {
    return _then(_SupernodeState(
      user: user == freezed ? _value.user : user as SupernodeUser,
      selectedNode: selectedNode == freezed
          ? _value.selectedNode
          : selectedNode as Supernode,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }
}

/// @nodoc
class _$_SupernodeState extends _SupernodeState with DiagnosticableTreeMixin {
  _$_SupernodeState({this.user, this.selectedNode, this.orgId}) : super._();

  @override
  final SupernodeUser user;
  @override
  final Supernode selectedNode;
  @override
  final String orgId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeState(user: $user, selectedNode: $selectedNode, orgId: $orgId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeState'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('selectedNode', selectedNode))
      ..add(DiagnosticsProperty('orgId', orgId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeState &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.selectedNode, selectedNode) ||
                const DeepCollectionEquality()
                    .equals(other.selectedNode, selectedNode)) &&
            (identical(other.orgId, orgId) ||
                const DeepCollectionEquality().equals(other.orgId, orgId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(selectedNode) ^
      const DeepCollectionEquality().hash(orgId);

  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith =>
      __$SupernodeStateCopyWithImpl<_SupernodeState>(this, _$identity);
}

abstract class _SupernodeState extends SupernodeState {
  _SupernodeState._() : super._();
  factory _SupernodeState(
      {SupernodeUser user,
      Supernode selectedNode,
      String orgId}) = _$_SupernodeState;

  @override
  SupernodeUser get user;
  @override
  Supernode get selectedNode;
  @override
  String get orgId;
  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith;
}

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call({Locale locale, bool isDemo = false}) {
    return _AppState(
      locale: locale,
      isDemo: isDemo,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  Locale get locale;
  bool get isDemo;

  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call({Locale locale, bool isDemo});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object locale = freezed,
    Object isDemo = freezed,
  }) {
    return _then(_value.copyWith(
      locale: locale == freezed ? _value.locale : locale as Locale,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
    ));
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call({Locale locale, bool isDemo});
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
    Object locale = freezed,
    Object isDemo = freezed,
  }) {
    return _then(_AppState(
      locale: locale == freezed ? _value.locale : locale as Locale,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
    ));
  }
}

/// @nodoc
class _$_AppState with DiagnosticableTreeMixin implements _AppState {
  _$_AppState({this.locale, this.isDemo = false}) : assert(isDemo != null);

  @override
  final Locale locale;
  @JsonKey(defaultValue: false)
  @override
  final bool isDemo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(locale: $locale, isDemo: $isDemo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('isDemo', isDemo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.isDemo, isDemo) ||
                const DeepCollectionEquality().equals(other.isDemo, isDemo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(isDemo);

  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState({Locale locale, bool isDemo}) = _$_AppState;

  @override
  Locale get locale;
  @override
  bool get isDemo;
  @override
  _$AppStateCopyWith<_AppState> get copyWith;
}

/// @nodoc
class _$SupernodeUserTearOff {
  const _$SupernodeUserTearOff();

// ignore: unused_element
  _SupernodeUser call(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled = false}) {
    return _SupernodeUser(
      userId: userId,
      username: username,
      token: token,
      password: password,
      node: node,
      tfaEnabled: tfaEnabled,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeUser = _$SupernodeUserTearOff();

/// @nodoc
mixin _$SupernodeUser {
  int get userId;
  String get username;
  String get token;
  String get password;
  Supernode get node;
  bool get tfaEnabled;

  $SupernodeUserCopyWith<SupernodeUser> get copyWith;
}

/// @nodoc
abstract class $SupernodeUserCopyWith<$Res> {
  factory $SupernodeUserCopyWith(
          SupernodeUser value, $Res Function(SupernodeUser) then) =
      _$SupernodeUserCopyWithImpl<$Res>;
  $Res call(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled});
}

/// @nodoc
class _$SupernodeUserCopyWithImpl<$Res>
    implements $SupernodeUserCopyWith<$Res> {
  _$SupernodeUserCopyWithImpl(this._value, this._then);

  final SupernodeUser _value;
  // ignore: unused_field
  final $Res Function(SupernodeUser) _then;

  @override
  $Res call({
    Object userId = freezed,
    Object username = freezed,
    Object token = freezed,
    Object password = freezed,
    Object node = freezed,
    Object tfaEnabled = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as int,
      username: username == freezed ? _value.username : username as String,
      token: token == freezed ? _value.token : token as String,
      password: password == freezed ? _value.password : password as String,
      node: node == freezed ? _value.node : node as Supernode,
      tfaEnabled:
          tfaEnabled == freezed ? _value.tfaEnabled : tfaEnabled as bool,
    ));
  }
}

/// @nodoc
abstract class _$SupernodeUserCopyWith<$Res>
    implements $SupernodeUserCopyWith<$Res> {
  factory _$SupernodeUserCopyWith(
          _SupernodeUser value, $Res Function(_SupernodeUser) then) =
      __$SupernodeUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled});
}

/// @nodoc
class __$SupernodeUserCopyWithImpl<$Res>
    extends _$SupernodeUserCopyWithImpl<$Res>
    implements _$SupernodeUserCopyWith<$Res> {
  __$SupernodeUserCopyWithImpl(
      _SupernodeUser _value, $Res Function(_SupernodeUser) _then)
      : super(_value, (v) => _then(v as _SupernodeUser));

  @override
  _SupernodeUser get _value => super._value as _SupernodeUser;

  @override
  $Res call({
    Object userId = freezed,
    Object username = freezed,
    Object token = freezed,
    Object password = freezed,
    Object node = freezed,
    Object tfaEnabled = freezed,
  }) {
    return _then(_SupernodeUser(
      userId: userId == freezed ? _value.userId : userId as int,
      username: username == freezed ? _value.username : username as String,
      token: token == freezed ? _value.token : token as String,
      password: password == freezed ? _value.password : password as String,
      node: node == freezed ? _value.node : node as Supernode,
      tfaEnabled:
          tfaEnabled == freezed ? _value.tfaEnabled : tfaEnabled as bool,
    ));
  }
}

/// @nodoc
class _$_SupernodeUser with DiagnosticableTreeMixin implements _SupernodeUser {
  _$_SupernodeUser(
      {this.userId,
      this.username,
      this.token,
      this.password,
      this.node,
      this.tfaEnabled = false})
      : assert(tfaEnabled != null);

  @override
  final int userId;
  @override
  final String username;
  @override
  final String token;
  @override
  final String password;
  @override
  final Supernode node;
  @JsonKey(defaultValue: false)
  @override
  final bool tfaEnabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeUser(userId: $userId, username: $username, token: $token, password: $password, node: $node, tfaEnabled: $tfaEnabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeUser'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('node', node))
      ..add(DiagnosticsProperty('tfaEnabled', tfaEnabled));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeUser &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.node, node) ||
                const DeepCollectionEquality().equals(other.node, node)) &&
            (identical(other.tfaEnabled, tfaEnabled) ||
                const DeepCollectionEquality()
                    .equals(other.tfaEnabled, tfaEnabled)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(node) ^
      const DeepCollectionEquality().hash(tfaEnabled);

  @override
  _$SupernodeUserCopyWith<_SupernodeUser> get copyWith =>
      __$SupernodeUserCopyWithImpl<_SupernodeUser>(this, _$identity);
}

abstract class _SupernodeUser implements SupernodeUser {
  factory _SupernodeUser(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled}) = _$_SupernodeUser;

  @override
  int get userId;
  @override
  String get username;
  @override
  String get token;
  @override
  String get password;
  @override
  Supernode get node;
  @override
  bool get tfaEnabled;
  @override
  _$SupernodeUserCopyWith<_SupernodeUser> get copyWith;
}
