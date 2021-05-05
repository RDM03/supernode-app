import 'package:web3dart/web3dart.dart';

class Ethereum {
  static isValidEthAddress(String address) {
    try {
      return EthereumAddress.fromHex(address) == null;
    } catch (e) {
      return false;
    }
  }
}
