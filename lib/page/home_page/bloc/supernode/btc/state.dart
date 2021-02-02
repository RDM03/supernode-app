import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.model.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class SupernodeBtcState with _$SupernodeBtcState {
  factory SupernodeBtcState({
    @Default(Wrap.pending()) Wrap<double> balance,
  }) = _SupernodeBtcState;
}
