// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$LoginStateTearOff {
  const _$LoginStateTearOff();

// ignore: unused_element
  _LoginState call(
      {bool supernodeListVisible = false,
      bool obscureText = false,
      @nullable Supernode selectedSuperNode,
      int showTestNodesCounter = 0,
      Wrap<Map<String, List<Supernode>>> supernodes = const Wrap.pending(),
      bool showLoading = false,
      bool showWeChatLoginOption = false,
      @nullable String errorMessage,
      @nullable LoginResult result}) {
    return _LoginState(
      supernodeListVisible: supernodeListVisible,
      obscureText: obscureText,
      selectedSuperNode: selectedSuperNode,
      showTestNodesCounter: showTestNodesCounter,
      supernodes: supernodes,
      showLoading: showLoading,
      showWeChatLoginOption: showWeChatLoginOption,
      errorMessage: errorMessage,
      result: result,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $LoginState = _$LoginStateTearOff();

/// @nodoc
mixin _$LoginState {
  bool get supernodeListVisible;
  bool get obscureText;
  @nullable
  Supernode get selectedSuperNode;
  int get showTestNodesCounter;
  Wrap<Map<String, List<Supernode>>> get supernodes;
  bool get showLoading;
  bool get showWeChatLoginOption;
  @nullable
  String get errorMessage;
  @nullable
  LoginResult get result;

  $LoginStateCopyWith<LoginState> get copyWith;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
  $Res call(
      {bool supernodeListVisible,
      bool obscureText,
      @nullable Supernode selectedSuperNode,
      int showTestNodesCounter,
      Wrap<Map<String, List<Supernode>>> supernodes,
      bool showLoading,
      bool showWeChatLoginOption,
      @nullable String errorMessage,
      @nullable LoginResult result});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;

  @override
  $Res call({
    Object supernodeListVisible = freezed,
    Object obscureText = freezed,
    Object selectedSuperNode = freezed,
    Object showTestNodesCounter = freezed,
    Object supernodes = freezed,
    Object showLoading = freezed,
    Object showWeChatLoginOption = freezed,
    Object errorMessage = freezed,
    Object result = freezed,
  }) {
    return _then(_value.copyWith(
      supernodeListVisible: supernodeListVisible == freezed
          ? _value.supernodeListVisible
          : supernodeListVisible as bool,
      obscureText:
          obscureText == freezed ? _value.obscureText : obscureText as bool,
      selectedSuperNode: selectedSuperNode == freezed
          ? _value.selectedSuperNode
          : selectedSuperNode as Supernode,
      showTestNodesCounter: showTestNodesCounter == freezed
          ? _value.showTestNodesCounter
          : showTestNodesCounter as int,
      supernodes: supernodes == freezed
          ? _value.supernodes
          : supernodes as Wrap<Map<String, List<Supernode>>>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      showWeChatLoginOption: showWeChatLoginOption == freezed
          ? _value.showWeChatLoginOption
          : showWeChatLoginOption as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage as String,
      result: result == freezed ? _value.result : result as LoginResult,
    ));
  }
}

/// @nodoc
abstract class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(
          _LoginState value, $Res Function(_LoginState) then) =
      __$LoginStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool supernodeListVisible,
      bool obscureText,
      @nullable Supernode selectedSuperNode,
      int showTestNodesCounter,
      Wrap<Map<String, List<Supernode>>> supernodes,
      bool showLoading,
      bool showWeChatLoginOption,
      @nullable String errorMessage,
      @nullable LoginResult result});
}

/// @nodoc
class __$LoginStateCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(
      _LoginState _value, $Res Function(_LoginState) _then)
      : super(_value, (v) => _then(v as _LoginState));

  @override
  _LoginState get _value => super._value as _LoginState;

  @override
  $Res call({
    Object supernodeListVisible = freezed,
    Object obscureText = freezed,
    Object selectedSuperNode = freezed,
    Object showTestNodesCounter = freezed,
    Object supernodes = freezed,
    Object showLoading = freezed,
    Object showWeChatLoginOption = freezed,
    Object errorMessage = freezed,
    Object result = freezed,
  }) {
    return _then(_LoginState(
      supernodeListVisible: supernodeListVisible == freezed
          ? _value.supernodeListVisible
          : supernodeListVisible as bool,
      obscureText:
          obscureText == freezed ? _value.obscureText : obscureText as bool,
      selectedSuperNode: selectedSuperNode == freezed
          ? _value.selectedSuperNode
          : selectedSuperNode as Supernode,
      showTestNodesCounter: showTestNodesCounter == freezed
          ? _value.showTestNodesCounter
          : showTestNodesCounter as int,
      supernodes: supernodes == freezed
          ? _value.supernodes
          : supernodes as Wrap<Map<String, List<Supernode>>>,
      showLoading:
          showLoading == freezed ? _value.showLoading : showLoading as bool,
      showWeChatLoginOption: showWeChatLoginOption == freezed
          ? _value.showWeChatLoginOption
          : showWeChatLoginOption as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage as String,
      result: result == freezed ? _value.result : result as LoginResult,
    ));
  }
}

/// @nodoc
class _$_LoginState extends _LoginState with DiagnosticableTreeMixin {
  _$_LoginState(
      {this.supernodeListVisible = false,
      this.obscureText = false,
      @nullable this.selectedSuperNode,
      this.showTestNodesCounter = 0,
      this.supernodes = const Wrap.pending(),
      this.showLoading = false,
      this.showWeChatLoginOption = false,
      @nullable this.errorMessage,
      @nullable this.result})
      : assert(supernodeListVisible != null),
        assert(obscureText != null),
        assert(showTestNodesCounter != null),
        assert(supernodes != null),
        assert(showLoading != null),
        assert(showWeChatLoginOption != null),
        super._();

  @JsonKey(defaultValue: false)
  @override
  final bool supernodeListVisible;
  @JsonKey(defaultValue: false)
  @override
  final bool obscureText;
  @override
  @nullable
  final Supernode selectedSuperNode;
  @JsonKey(defaultValue: 0)
  @override
  final int showTestNodesCounter;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<Map<String, List<Supernode>>> supernodes;
  @JsonKey(defaultValue: false)
  @override
  final bool showLoading;
  @JsonKey(defaultValue: false)
  @override
  final bool showWeChatLoginOption;
  @override
  @nullable
  final String errorMessage;
  @override
  @nullable
  final LoginResult result;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginState(supernodeListVisible: $supernodeListVisible, obscureText: $obscureText, selectedSuperNode: $selectedSuperNode, showTestNodesCounter: $showTestNodesCounter, supernodes: $supernodes, showLoading: $showLoading, showWeChatLoginOption: $showWeChatLoginOption, errorMessage: $errorMessage, result: $result)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginState'))
      ..add(DiagnosticsProperty('supernodeListVisible', supernodeListVisible))
      ..add(DiagnosticsProperty('obscureText', obscureText))
      ..add(DiagnosticsProperty('selectedSuperNode', selectedSuperNode))
      ..add(DiagnosticsProperty('showTestNodesCounter', showTestNodesCounter))
      ..add(DiagnosticsProperty('supernodes', supernodes))
      ..add(DiagnosticsProperty('showLoading', showLoading))
      ..add(DiagnosticsProperty('showWeChatLoginOption', showWeChatLoginOption))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginState &&
            (identical(other.supernodeListVisible, supernodeListVisible) ||
                const DeepCollectionEquality().equals(
                    other.supernodeListVisible, supernodeListVisible)) &&
            (identical(other.obscureText, obscureText) ||
                const DeepCollectionEquality()
                    .equals(other.obscureText, obscureText)) &&
            (identical(other.selectedSuperNode, selectedSuperNode) ||
                const DeepCollectionEquality()
                    .equals(other.selectedSuperNode, selectedSuperNode)) &&
            (identical(other.showTestNodesCounter, showTestNodesCounter) ||
                const DeepCollectionEquality().equals(
                    other.showTestNodesCounter, showTestNodesCounter)) &&
            (identical(other.supernodes, supernodes) ||
                const DeepCollectionEquality()
                    .equals(other.supernodes, supernodes)) &&
            (identical(other.showLoading, showLoading) ||
                const DeepCollectionEquality()
                    .equals(other.showLoading, showLoading)) &&
            (identical(other.showWeChatLoginOption, showWeChatLoginOption) ||
                const DeepCollectionEquality().equals(
                    other.showWeChatLoginOption, showWeChatLoginOption)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)) &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(supernodeListVisible) ^
      const DeepCollectionEquality().hash(obscureText) ^
      const DeepCollectionEquality().hash(selectedSuperNode) ^
      const DeepCollectionEquality().hash(showTestNodesCounter) ^
      const DeepCollectionEquality().hash(supernodes) ^
      const DeepCollectionEquality().hash(showLoading) ^
      const DeepCollectionEquality().hash(showWeChatLoginOption) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      const DeepCollectionEquality().hash(result);

  @override
  _$LoginStateCopyWith<_LoginState> get copyWith =>
      __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);
}

abstract class _LoginState extends LoginState {
  _LoginState._() : super._();
  factory _LoginState(
      {bool supernodeListVisible,
      bool obscureText,
      @nullable Supernode selectedSuperNode,
      int showTestNodesCounter,
      Wrap<Map<String, List<Supernode>>> supernodes,
      bool showLoading,
      bool showWeChatLoginOption,
      @nullable String errorMessage,
      @nullable LoginResult result}) = _$_LoginState;

  @override
  bool get supernodeListVisible;
  @override
  bool get obscureText;
  @override
  @nullable
  Supernode get selectedSuperNode;
  @override
  int get showTestNodesCounter;
  @override
  Wrap<Map<String, List<Supernode>>> get supernodes;
  @override
  bool get showLoading;
  @override
  bool get showWeChatLoginOption;
  @override
  @nullable
  String get errorMessage;
  @override
  @nullable
  LoginResult get result;
  @override
  _$LoginStateCopyWith<_LoginState> get copyWith;
}
