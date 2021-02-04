import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class SupernodeBtcState with _$SupernodeBtcState {
  factory SupernodeBtcState({
    @Default(Wrap.pending()) Wrap<double> balance,
    @Default(Wrap.pending()) Wrap<List<WithdrawHistoryEntity>> withdraws,
  }) = _SupernodeBtcState;
}
