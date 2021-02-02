import 'dart:ui';

import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';

enum CurrencyType { fiat, crypto }
enum Token { mxc, supernodeDhx, btc }

extension TokenExtension on Token {
  String get fullName {
    switch (this) {
      case Token.supernodeDhx:
        return 'Datahighway DHX';
      case Token.mxc:
        return 'MXC';
      case Token.btc:
        return 'Bitcoin BTC';
    }
    throw UnimplementedError('No name found for $this');
  }

  String get name {
    switch (this) {
      case Token.supernodeDhx:
        return 'DHX';
      case Token.mxc:
        return 'MXC';
      case Token.btc:
        return 'BTC';
    }
    throw UnimplementedError('No name found for $this');
  }

  String get imagePath {
    switch (this) {
      case Token.supernodeDhx:
        return AppImages.logoDHX;
      case Token.mxc:
        return AppImages.logoMXC;
      case Token.btc:
        return AppImages.logoBTC;
    }
    throw UnimplementedError('No image found for $this');
  }

  Color get color {
    switch (this) {
      case Token.supernodeDhx:
        return colorSupernodeDhx;
      case Token.mxc:
        return colorMxc;
      case Token.btc:
        return colorBtc;
    }
    throw UnimplementedError('No color found for $this');
  }
}

class Currency {
  final String iconPath;
  final String shortName;
  final CurrencyType type;

  Currency(this.shortName, this.iconPath, [this.type = CurrencyType.fiat]);

  String toString() => shortName;

  static List<Currency> get values => [
        usd,
        btc,
        cny,
        eth,
        krw,
        aed,
        ars,
        aud,
        bdt,
        bmd,
        brl,
        cad,
        chf,
        clp,
        czk,
        dkk,
        eur,
        gbp,
        hkd,
        huf,
        idr,
        ils,
        inr,
        jpy,
        kwd,
        lkr,
        mmk,
        mxn,
        myr,
        nok,
        nzd,
        php,
        pkr,
        pln,
        rub,
        sar,
        sek,
        sgd,
        tbh,
        try0,
        twd,
        uah,
        vef,
        vnd,
        zar,
        bch,
        bhd,
        bnb,
        eos,
        ltc,
        xlm,
        xrp,
        mxc
      ];

  static final usd =
      Currency('usd', 'assets/images/calculator/currencies/usd.png');
  static final cny =
      Currency('cny', 'assets/images/calculator/currencies/cny.png');
  static final krw =
      Currency('krw', 'assets/images/calculator/currencies/krw.png');
  static final aed =
      Currency('aed', 'assets/images/calculator/currencies/aed.png');
  static final ars =
      Currency('ars', 'assets/images/calculator/currencies/ars.png');
  static final aud =
      Currency('aud', 'assets/images/calculator/currencies/aud.png');
  static final bdt =
      Currency('bdt', 'assets/images/calculator/currencies/bdt.png');
  static final bmd =
      Currency('bmd', 'assets/images/calculator/currencies/bmd.png');
  static final brl =
      Currency('brl', 'assets/images/calculator/currencies/brl.png');
  static final cad =
      Currency('cad', 'assets/images/calculator/currencies/cad.png');
  static final chf =
      Currency('chf', 'assets/images/calculator/currencies/chf.png');
  static final clp =
      Currency('clp', 'assets/images/calculator/currencies/clp.png');
  static final czk =
      Currency('czk', 'assets/images/calculator/currencies/czk.png');
  static final dkk =
      Currency('dkk', 'assets/images/calculator/currencies/dkk.png');
  static final eur =
      Currency('eur', 'assets/images/calculator/currencies/eur.png');
  static final gbp =
      Currency('gbp', 'assets/images/calculator/currencies/gbp.png');
  static final hkd =
      Currency('hkd', 'assets/images/calculator/currencies/hkd.png');
  static final huf =
      Currency('huf', 'assets/images/calculator/currencies/huf.png');
  static final idr =
      Currency('idr', 'assets/images/calculator/currencies/idr.png');
  static final ils =
      Currency('ils', 'assets/images/calculator/currencies/ils.png');
  static final inr =
      Currency('inr', 'assets/images/calculator/currencies/inr.png');
  static final jpy =
      Currency('jpy', 'assets/images/calculator/currencies/jpy.png');
  static final kwd =
      Currency('kwd', 'assets/images/calculator/currencies/kwd.png');
  static final lkr =
      Currency('lkr', 'assets/images/calculator/currencies/lkr.png');
  static final mmk =
      Currency('mmk', 'assets/images/calculator/currencies/mmk.png');
  static final mxn =
      Currency('mxn', 'assets/images/calculator/currencies/mxn.png');
  static final myr =
      Currency('myr', 'assets/images/calculator/currencies/myr.png');
  static final nok =
      Currency('nok', 'assets/images/calculator/currencies/nok.png');
  static final nzd =
      Currency('nzd', 'assets/images/calculator/currencies/nzd.png');
  static final php =
      Currency('php', 'assets/images/calculator/currencies/php.png');
  static final pkr =
      Currency('pkr', 'assets/images/calculator/currencies/pkr.png');
  static final pln =
      Currency('pln', 'assets/images/calculator/currencies/pln.png');
  static final rub =
      Currency('rub', 'assets/images/calculator/currencies/rub.png');
  static final sar =
      Currency('sar', 'assets/images/calculator/currencies/sar.png');
  static final sek =
      Currency('sek', 'assets/images/calculator/currencies/sek.png');
  static final sgd =
      Currency('sgd', 'assets/images/calculator/currencies/sgd.png');
  static final tbh =
      Currency('tbh', 'assets/images/calculator/currencies/tbh.png');
  static final try0 =
      Currency('try', 'assets/images/calculator/currencies/try.png');
  static final twd =
      Currency('twd', 'assets/images/calculator/currencies/twd.png');
  static final uah =
      Currency('uah', 'assets/images/calculator/currencies/uah.png');
  static final vef =
      Currency('vef', 'assets/images/calculator/currencies/vef.png');
  static final vnd =
      Currency('vnd', 'assets/images/calculator/currencies/vnd.png');
  static final zar =
      Currency('zar', 'assets/images/calculator/currencies/zar.png');

  static final bch = Currency('bch',
      'assets/images/calculator/currencies/bch.png', CurrencyType.crypto);
  static final bhd = Currency('bhd',
      'assets/images/calculator/currencies/bhd.png', CurrencyType.crypto);
  static final bnb = Currency('bnb',
      'assets/images/calculator/currencies/bnb.png', CurrencyType.crypto);
  static final eos = Currency('eos',
      'assets/images/calculator/currencies/eos.png', CurrencyType.crypto);
  static final ltc = Currency('ltc',
      'assets/images/calculator/currencies/ltc.png', CurrencyType.crypto);
  static final xlm = Currency('xlm',
      'assets/images/calculator/currencies/xlm.png', CurrencyType.crypto);
  static final xrp = Currency('xrp',
      'assets/images/calculator/currencies/xrp.png', CurrencyType.crypto);
  static final mxc = Currency('mxc',
      'assets/images/calculator/currencies/mxc.png', CurrencyType.crypto);
  static final btc = Currency('btc',
      'assets/images/calculator/currencies/btc.png', CurrencyType.crypto);
  static final eth = Currency('eth',
      'assets/images/calculator/currencies/eth.png', CurrencyType.crypto);
}
