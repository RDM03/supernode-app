import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';

part 'state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  factory SettingsState({

    @nullable PackageInfo info,
    @nullable List<FiatCurrency> listFiat,
    @nullable FiatCurrency selectedFiat,
    @nullable DateTime startDate,
    @nullable DateTime endDate,
    @Default(4) int decimals,

    @nullable String version,
    @nullable String buildNumber,
    @nullable String mxVersion,

    @nullable String language,
    @Default(2021) int copyrightYear,
    bool screenShot,
    bool showWechatUnbindConfirmation,
    int showBindShopifyStep,
    bool showLoading,
  }) = _SettingsState;
}
