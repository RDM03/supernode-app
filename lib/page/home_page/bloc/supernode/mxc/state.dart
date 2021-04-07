import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class SupernodeMxcState with _$SupernodeMxcState {
  factory SupernodeMxcState({
    @Default(Wrap.pending()) Wrap<List<StakeHistoryEntity>> stakes,
    @Default(Wrap.pending()) Wrap<List<WithdrawHistoryEntity>> withdraws,
    @Default(Wrap.pending()) Wrap<List<TopupEntity>> topups,
  }) = _SupernodeMxcState;
}
