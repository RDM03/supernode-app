import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class WalletState with _$WalletState {
  factory WalletState({
    @Default(false) bool expanded,
    @nullable Token selectedToken,
    @Default(const [Token.mxc]) List<Token> displayTokens,
    @Default(Wrap.pending()) Wrap<List<StakeHistoryEntity>> stakes,
    @Default(Wrap.pending()) Wrap<List<WithdrawHistoryEntity>> withdraws,
    @Default(Wrap.pending()) Wrap<List<TopupEntity>> topups,
  }) = _WalletState;
}
