// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call(
      {Locale locale, bool isDemo = false, bool showLoading = false}) {
    return _AppState(
      locale: locale,
      isDemo: isDemo,
      showLoading: showLoading,
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
  bool get showLoading;

  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call({Locale locale, bool isDemo, bool showLoading});
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
    Object showLoading = freezed,
  }) {
    return _then(_value.copyWith(
      locale: locale == freezed ? _value.locale : locale as Locale,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
    ));
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call({Locale locale, bool isDemo, bool showLoading});
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
    Object showLoading = freezed,
  }) {
    return _then(_AppState(
      locale: locale == freezed ? _value.locale : locale as Locale,
      isDemo: isDemo == freezed ? _value.isDemo : isDemo as bool,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
    ));
  }
}

/// @nodoc
class _$_AppState with DiagnosticableTreeMixin implements _AppState {
  _$_AppState({this.locale, this.isDemo = false, this.showLoading = false})
      : assert(isDemo != null),
        assert(showLoading != null);

  @override
  final Locale locale;
  @JsonKey(defaultValue: false)
  @override
  final bool isDemo;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(locale: $locale, isDemo: $isDemo, showLoading: $showLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('isDemo', isDemo))
      ..add(DiagnosticsProperty('showLoading', showLoading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.isDemo, isDemo) ||
                const DeepCollectionEquality().equals(other.isDemo, isDemo)) &&
            (identical(other.showLoading, showLoading) ||
                const DeepCollectionEquality()
                    .equals(other.showLoading, showLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(isDemo) ^
      const DeepCollectionEquality().hash(showLoading);

  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState({Locale locale, bool isDemo, bool showLoading}) =
      _$_AppState;

  @override
  Locale get locale;
  @override
  bool get isDemo;
  @override
  bool get showLoading;
  @override
  _$AppStateCopyWith<_AppState> get copyWith;
}

/// @nodoc
class _$SupernodeStateTearOff {
  const _$SupernodeStateTearOff();

// ignore: unused_element
  _SupernodeState call(
      {SupernodeSession session, Supernode selectedNode, String orgId}) {
    return _SupernodeState(
      session: session,
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
  SupernodeSession get session;
  Supernode get selectedNode;
  String get orgId;

  $SupernodeStateCopyWith<SupernodeState> get copyWith;
}

/// @nodoc
abstract class $SupernodeStateCopyWith<$Res> {
  factory $SupernodeStateCopyWith(
          SupernodeState value, $Res Function(SupernodeState) then) =
      _$SupernodeStateCopyWithImpl<$Res>;
  $Res call({SupernodeSession session, Supernode selectedNode, String orgId});

  $SupernodeSessionCopyWith<$Res> get session;
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
    Object session = freezed,
    Object selectedNode = freezed,
    Object orgId = freezed,
  }) {
    return _then(_value.copyWith(
      session:
          session == freezed ? _value.session : session as SupernodeSession,
      selectedNode: selectedNode == freezed
          ? _value.selectedNode
          : selectedNode as Supernode,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }

  @override
  $SupernodeSessionCopyWith<$Res> get session {
    if (_value.session == null) {
      return null;
    }
    return $SupernodeSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
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
  $Res call({SupernodeSession session, Supernode selectedNode, String orgId});

  @override
  $SupernodeSessionCopyWith<$Res> get session;
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
    Object session = freezed,
    Object selectedNode = freezed,
    Object orgId = freezed,
  }) {
    return _then(_SupernodeState(
      session:
          session == freezed ? _value.session : session as SupernodeSession,
      selectedNode: selectedNode == freezed
          ? _value.selectedNode
          : selectedNode as Supernode,
      orgId: orgId == freezed ? _value.orgId : orgId as String,
    ));
  }
}

/// @nodoc
class _$_SupernodeState extends _SupernodeState with DiagnosticableTreeMixin {
  _$_SupernodeState({this.session, this.selectedNode, this.orgId}) : super._();

  @override
  final SupernodeSession session;
  @override
  final Supernode selectedNode;
  @override
  final String orgId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeState(session: $session, selectedNode: $selectedNode, orgId: $orgId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeState'))
      ..add(DiagnosticsProperty('session', session))
      ..add(DiagnosticsProperty('selectedNode', selectedNode))
      ..add(DiagnosticsProperty('orgId', orgId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeState &&
            (identical(other.session, session) ||
                const DeepCollectionEquality()
                    .equals(other.session, session)) &&
            (identical(other.selectedNode, selectedNode) ||
                const DeepCollectionEquality()
                    .equals(other.selectedNode, selectedNode)) &&
            (identical(other.orgId, orgId) ||
                const DeepCollectionEquality().equals(other.orgId, orgId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(session) ^
      const DeepCollectionEquality().hash(selectedNode) ^
      const DeepCollectionEquality().hash(orgId);

  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith =>
      __$SupernodeStateCopyWithImpl<_SupernodeState>(this, _$identity);
}

abstract class _SupernodeState extends SupernodeState {
  _SupernodeState._() : super._();
  factory _SupernodeState(
      {SupernodeSession session,
      Supernode selectedNode,
      String orgId}) = _$_SupernodeState;

  @override
  SupernodeSession get session;
  @override
  Supernode get selectedNode;
  @override
  String get orgId;
  @override
  _$SupernodeStateCopyWith<_SupernodeState> get copyWith;
}

/// @nodoc
class _$SupernodeSessionTearOff {
  const _$SupernodeSessionTearOff();

// ignore: unused_element
  _SupernodeSession call(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled = false}) {
    return _SupernodeSession(
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
const $SupernodeSession = _$SupernodeSessionTearOff();

/// @nodoc
mixin _$SupernodeSession {
  int get userId;
  String get username;
  String get token;
  String get password;
  Supernode get node;
  bool get tfaEnabled;

  $SupernodeSessionCopyWith<SupernodeSession> get copyWith;
}

/// @nodoc
abstract class $SupernodeSessionCopyWith<$Res> {
  factory $SupernodeSessionCopyWith(
          SupernodeSession value, $Res Function(SupernodeSession) then) =
      _$SupernodeSessionCopyWithImpl<$Res>;
  $Res call(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled});
}

/// @nodoc
class _$SupernodeSessionCopyWithImpl<$Res>
    implements $SupernodeSessionCopyWith<$Res> {
  _$SupernodeSessionCopyWithImpl(this._value, this._then);

  final SupernodeSession _value;
  // ignore: unused_field
  final $Res Function(SupernodeSession) _then;

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
abstract class _$SupernodeSessionCopyWith<$Res>
    implements $SupernodeSessionCopyWith<$Res> {
  factory _$SupernodeSessionCopyWith(
          _SupernodeSession value, $Res Function(_SupernodeSession) then) =
      __$SupernodeSessionCopyWithImpl<$Res>;
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
class __$SupernodeSessionCopyWithImpl<$Res>
    extends _$SupernodeSessionCopyWithImpl<$Res>
    implements _$SupernodeSessionCopyWith<$Res> {
  __$SupernodeSessionCopyWithImpl(
      _SupernodeSession _value, $Res Function(_SupernodeSession) _then)
      : super(_value, (v) => _then(v as _SupernodeSession));

  @override
  _SupernodeSession get _value => super._value as _SupernodeSession;

  @override
  $Res call({
    Object userId = freezed,
    Object username = freezed,
    Object token = freezed,
    Object password = freezed,
    Object node = freezed,
    Object tfaEnabled = freezed,
  }) {
    return _then(_SupernodeSession(
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
class _$_SupernodeSession
    with DiagnosticableTreeMixin
    implements _SupernodeSession {
  _$_SupernodeSession(
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
    return 'SupernodeSession(userId: $userId, username: $username, token: $token, password: $password, node: $node, tfaEnabled: $tfaEnabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeSession'))
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
        (other is _SupernodeSession &&
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
  _$SupernodeSessionCopyWith<_SupernodeSession> get copyWith =>
      __$SupernodeSessionCopyWithImpl<_SupernodeSession>(this, _$identity);
}

abstract class _SupernodeSession implements SupernodeSession {
  factory _SupernodeSession(
      {int userId,
      String username,
      String token,
      String password,
      Supernode node,
      bool tfaEnabled}) = _$_SupernodeSession;

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
  _$SupernodeSessionCopyWith<_SupernodeSession> get copyWith;
}

/// @nodoc
class _$DataHighwayStateTearOff {
  const _$DataHighwayStateTearOff();

// ignore: unused_element
  _DataHighwayState call({DataHighwaySession session}) {
    return _DataHighwayState(
      session: session,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DataHighwayState = _$DataHighwayStateTearOff();

/// @nodoc
mixin _$DataHighwayState {
  DataHighwaySession get session;

  $DataHighwayStateCopyWith<DataHighwayState> get copyWith;
}

/// @nodoc
abstract class $DataHighwayStateCopyWith<$Res> {
  factory $DataHighwayStateCopyWith(
          DataHighwayState value, $Res Function(DataHighwayState) then) =
      _$DataHighwayStateCopyWithImpl<$Res>;
  $Res call({DataHighwaySession session});

  $DataHighwaySessionCopyWith<$Res> get session;
}

/// @nodoc
class _$DataHighwayStateCopyWithImpl<$Res>
    implements $DataHighwayStateCopyWith<$Res> {
  _$DataHighwayStateCopyWithImpl(this._value, this._then);

  final DataHighwayState _value;
  // ignore: unused_field
  final $Res Function(DataHighwayState) _then;

  @override
  $Res call({
    Object session = freezed,
  }) {
    return _then(_value.copyWith(
      session:
          session == freezed ? _value.session : session as DataHighwaySession,
    ));
  }

  @override
  $DataHighwaySessionCopyWith<$Res> get session {
    if (_value.session == null) {
      return null;
    }
    return $DataHighwaySessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc
abstract class _$DataHighwayStateCopyWith<$Res>
    implements $DataHighwayStateCopyWith<$Res> {
  factory _$DataHighwayStateCopyWith(
          _DataHighwayState value, $Res Function(_DataHighwayState) then) =
      __$DataHighwayStateCopyWithImpl<$Res>;
  @override
  $Res call({DataHighwaySession session});

  @override
  $DataHighwaySessionCopyWith<$Res> get session;
}

/// @nodoc
class __$DataHighwayStateCopyWithImpl<$Res>
    extends _$DataHighwayStateCopyWithImpl<$Res>
    implements _$DataHighwayStateCopyWith<$Res> {
  __$DataHighwayStateCopyWithImpl(
      _DataHighwayState _value, $Res Function(_DataHighwayState) _then)
      : super(_value, (v) => _then(v as _DataHighwayState));

  @override
  _DataHighwayState get _value => super._value as _DataHighwayState;

  @override
  $Res call({
    Object session = freezed,
  }) {
    return _then(_DataHighwayState(
      session:
          session == freezed ? _value.session : session as DataHighwaySession,
    ));
  }
}

/// @nodoc
class _$_DataHighwayState extends _DataHighwayState
    with DiagnosticableTreeMixin {
  _$_DataHighwayState({this.session}) : super._();

  @override
  final DataHighwaySession session;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataHighwayState(session: $session)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataHighwayState'))
      ..add(DiagnosticsProperty('session', session));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DataHighwayState &&
            (identical(other.session, session) ||
                const DeepCollectionEquality().equals(other.session, session)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(session);

  @override
  _$DataHighwayStateCopyWith<_DataHighwayState> get copyWith =>
      __$DataHighwayStateCopyWithImpl<_DataHighwayState>(this, _$identity);
}

abstract class _DataHighwayState extends DataHighwayState {
  _DataHighwayState._() : super._();
  factory _DataHighwayState({DataHighwaySession session}) = _$_DataHighwayState;

  @override
  DataHighwaySession get session;
  @override
  _$DataHighwayStateCopyWith<_DataHighwayState> get copyWith;
}

/// @nodoc
class _$DataHighwaySessionTearOff {
  const _$DataHighwaySessionTearOff();

// ignore: unused_element
  _DataHighwaySession call({String address}) {
    return _DataHighwaySession(
      address: address,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DataHighwaySession = _$DataHighwaySessionTearOff();

/// @nodoc
mixin _$DataHighwaySession {
  String get address;

  $DataHighwaySessionCopyWith<DataHighwaySession> get copyWith;
}

/// @nodoc
abstract class $DataHighwaySessionCopyWith<$Res> {
  factory $DataHighwaySessionCopyWith(
          DataHighwaySession value, $Res Function(DataHighwaySession) then) =
      _$DataHighwaySessionCopyWithImpl<$Res>;
  $Res call({String address});
}

/// @nodoc
class _$DataHighwaySessionCopyWithImpl<$Res>
    implements $DataHighwaySessionCopyWith<$Res> {
  _$DataHighwaySessionCopyWithImpl(this._value, this._then);

  final DataHighwaySession _value;
  // ignore: unused_field
  final $Res Function(DataHighwaySession) _then;

  @override
  $Res call({
    Object address = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed ? _value.address : address as String,
    ));
  }
}

/// @nodoc
abstract class _$DataHighwaySessionCopyWith<$Res>
    implements $DataHighwaySessionCopyWith<$Res> {
  factory _$DataHighwaySessionCopyWith(
          _DataHighwaySession value, $Res Function(_DataHighwaySession) then) =
      __$DataHighwaySessionCopyWithImpl<$Res>;
  @override
  $Res call({String address});
}

/// @nodoc
class __$DataHighwaySessionCopyWithImpl<$Res>
    extends _$DataHighwaySessionCopyWithImpl<$Res>
    implements _$DataHighwaySessionCopyWith<$Res> {
  __$DataHighwaySessionCopyWithImpl(
      _DataHighwaySession _value, $Res Function(_DataHighwaySession) _then)
      : super(_value, (v) => _then(v as _DataHighwaySession));

  @override
  _DataHighwaySession get _value => super._value as _DataHighwaySession;

  @override
  $Res call({
    Object address = freezed,
  }) {
    return _then(_DataHighwaySession(
      address: address == freezed ? _value.address : address as String,
    ));
  }
}

/// @nodoc
class _$_DataHighwaySession extends _DataHighwaySession
    with DiagnosticableTreeMixin {
  _$_DataHighwaySession({this.address}) : super._();

  @override
  final String address;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataHighwaySession(address: $address)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataHighwaySession'))
      ..add(DiagnosticsProperty('address', address));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DataHighwaySession &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(address);

  @override
  _$DataHighwaySessionCopyWith<_DataHighwaySession> get copyWith =>
      __$DataHighwaySessionCopyWithImpl<_DataHighwaySession>(this, _$identity);
}

abstract class _DataHighwaySession extends DataHighwaySession {
  _DataHighwaySession._() : super._();
  factory _DataHighwaySession({String address}) = _$_DataHighwaySession;

  @override
  String get address;
  @override
  _$DataHighwaySessionCopyWith<_DataHighwaySession> get copyWith;
}
