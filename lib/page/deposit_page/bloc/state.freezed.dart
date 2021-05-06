// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DepositStateTearOff {
  const _$DepositStateTearOff();

// ignore: unused_element
  _DepositState call({Wrap<String> address = const Wrap.pending()}) {
    return _DepositState(
      address: address,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DepositState = _$DepositStateTearOff();

/// @nodoc
mixin _$DepositState {
  Wrap<String> get address;

  @JsonKey(ignore: true)
  $DepositStateCopyWith<DepositState> get copyWith;
}

/// @nodoc
abstract class $DepositStateCopyWith<$Res> {
  factory $DepositStateCopyWith(
          DepositState value, $Res Function(DepositState) then) =
      _$DepositStateCopyWithImpl<$Res>;
  $Res call({Wrap<String> address});
}

/// @nodoc
class _$DepositStateCopyWithImpl<$Res> implements $DepositStateCopyWith<$Res> {
  _$DepositStateCopyWithImpl(this._value, this._then);

  final DepositState _value;
  // ignore: unused_field
  final $Res Function(DepositState) _then;

  @override
  $Res call({
    Object address = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed ? _value.address : address as Wrap<String>,
    ));
  }
}

/// @nodoc
abstract class _$DepositStateCopyWith<$Res>
    implements $DepositStateCopyWith<$Res> {
  factory _$DepositStateCopyWith(
          _DepositState value, $Res Function(_DepositState) then) =
      __$DepositStateCopyWithImpl<$Res>;
  @override
  $Res call({Wrap<String> address});
}

/// @nodoc
class __$DepositStateCopyWithImpl<$Res> extends _$DepositStateCopyWithImpl<$Res>
    implements _$DepositStateCopyWith<$Res> {
  __$DepositStateCopyWithImpl(
      _DepositState _value, $Res Function(_DepositState) _then)
      : super(_value, (v) => _then(v as _DepositState));

  @override
  _DepositState get _value => super._value as _DepositState;

  @override
  $Res call({
    Object address = freezed,
  }) {
    return _then(_DepositState(
      address: address == freezed ? _value.address : address as Wrap<String>,
    ));
  }
}

/// @nodoc
class _$_DepositState extends _DepositState with DiagnosticableTreeMixin {
  _$_DepositState({this.address = const Wrap.pending()})
      : assert(address != null),
        super._();

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<String> address;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DepositState(address: $address)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DepositState'))
      ..add(DiagnosticsProperty('address', address));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DepositState &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(address);

  @JsonKey(ignore: true)
  @override
  _$DepositStateCopyWith<_DepositState> get copyWith =>
      __$DepositStateCopyWithImpl<_DepositState>(this, _$identity);
}

abstract class _DepositState extends DepositState {
  _DepositState._() : super._();
  factory _DepositState({Wrap<String> address}) = _$_DepositState;

  @override
  Wrap<String> get address;
  @override
  @JsonKey(ignore: true)
  _$DepositStateCopyWith<_DepositState> get copyWith;
}
