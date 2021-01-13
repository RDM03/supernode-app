import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/dhx_dao.dart';
import 'package:supernodeapp/common/daos/demo/gateways_dao.dart';
import 'package:supernodeapp/common/daos/demo/stake_dao.dart';
import 'package:supernodeapp/common/daos/demo/topup_dao.dart';
import 'package:supernodeapp/common/daos/demo/user_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/demo/withdraw_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/gateways_location_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';

abstract class SupernodeDaoHolder {
  WalletDao get wallet;
  DhxDao get dhx;
  GatewaysDao get gateways;
  StakeDao get stake;
  TopupDao get topup;
  UserDao get user;
  WithdrawDao get withdraw;
  GatewaysLocationDao get gatewaysLocation;
}

class SupernodeDemoDao implements SupernodeDaoHolder {
  @override
  final DemoDhxDao dhx = DemoDhxDao();

  @override
  final DemoGatewaysDao gateways = DemoGatewaysDao();

  @override
  final DemoStakeDao stake = DemoStakeDao();

  @override
  final DemoTopupDao topup = DemoTopupDao();

  @override
  final DemoUserDao user = DemoUserDao();

  @override
  final DemoWalletDao wallet = DemoWalletDao();

  @override
  final DemoWithdrawDao withdraw = DemoWithdrawDao();

  @override
  final GatewaysLocationDao gatewaysLocation = GatewaysLocationDao();
}

class SupernodeMainDao implements SupernodeDaoHolder {
  @override
  final DhxDao dhx = DhxDao();

  @override
  final GatewaysDao gateways = GatewaysDao();

  @override
  final StakeDao stake = StakeDao();

  @override
  final TopupDao topup = TopupDao();

  @override
  final UserDao user = UserDao();

  @override
  final WalletDao wallet = WalletDao();

  @override
  final WithdrawDao withdraw = WithdrawDao();

  @override
  final GatewaysLocationDao gatewaysLocation = GatewaysLocationDao();
}

class SupernodeRepository implements SupernodeDaoHolder {
  final demo = SupernodeDemoDao();
  final main = SupernodeMainDao();
  final AppCubit appCubit;

  SupernodeRepository(this.appCubit);

  SupernodeDaoHolder get _currentHolder => appCubit.state.isDemo ? demo : main;

  @override
  DhxDao get dhx => _currentHolder.dhx;

  @override
  GatewaysDao get gateways => _currentHolder.gateways;

  @override
  StakeDao get stake => _currentHolder.stake;

  @override
  TopupDao get topup => _currentHolder.topup;

  @override
  UserDao get user => _currentHolder.user;

  @override
  WalletDao get wallet => _currentHolder.wallet;

  @override
  WithdrawDao get withdraw => _currentHolder.withdraw;

  @override
  GatewaysLocationDao get gatewaysLocation => _currentHolder.gatewaysLocation;
}
