import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/configs/images.dart';

part 'state.freezed.dart';

@freezed
abstract class WalletState with _$WalletState {
  factory WalletState({
    @Default(false) bool expanded,
    @nullable WalletToken selectedToken,
    @Default(const [WalletToken.mxc]) List<WalletToken> displayTokens,
    @Default(Wrap.pending()) Wrap<List<StakeHistoryEntity>> stakes,
    @Default(Wrap.pending()) Wrap<List<WithdrawHistoryEntity>> withdraws,
    @Default(Wrap.pending()) Wrap<List<TopupEntity>> topups,
  }) = _WalletState;
}

enum WalletToken { supernodeDhx, mxc }

extension WalletTokenExtension on WalletToken {
  String get fullName {
    switch (this) {
      case WalletToken.supernodeDhx:
        return 'Datahighway DHX';
      case WalletToken.mxc:
        return 'MXC';
    }
    throw UnimplementedError('No name found for $this');
  }

  String get name {
    switch (this) {
      case WalletToken.supernodeDhx:
        return 'DHX';
      case WalletToken.mxc:
        return 'MXC';
    }
    throw UnimplementedError('No name found for $this');
  }

  String get imagePath {
    switch (this) {
      case WalletToken.supernodeDhx:
        return AppImages.logoDHX;
      case WalletToken.mxc:
        return AppImages.logoMXC;
    }
    throw UnimplementedError('No image found for $this');
  }

  Token toGeneralToken() {
    switch (this) {
      case WalletToken.supernodeDhx:
        return Token.DHX;
      case WalletToken.mxc:
        return Token.MXC;
    }
    throw UnimplementedError('No image found for $this');
  }
}
