import 'package:dio/dio.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/shared/clients/shared_client.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/interceptors/error_interceptor.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/interceptors/headers_interceptor.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/demo/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/network_server.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/organization.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';

import 'supernode/dao/dhx.dart';
import 'supernode/dao/gateways.dart';
import 'supernode/dao/gateways_location.dart';
import 'supernode/dao/stake.dart';
import 'supernode/dao/topup.dart';
import 'supernode/dao/user.dart';
import 'supernode/dao/wallet.dart';
import 'supernode/dao/withdraw.dart';

import 'supernode/dao/demo/dhx.dart';
import 'supernode/dao/demo/gateways.dart';
import 'supernode/dao/demo/stake.dart';
import 'supernode/dao/demo/topup.dart';
import 'supernode/dao/demo/user.dart';
import 'supernode/dao/demo/wallet.dart';
import 'supernode/dao/demo/withdraw.dart';

abstract class SupernodeDaoHolder {
  WalletDao get wallet;
  DhxDao get dhx;
  GatewaysDao get gateways;
  StakeDao get stake;
  TopupDao get topup;
  UserDao get user;
  WithdrawDao get withdraw;
  GatewaysLocationDao get gatewaysLocation;
  OrganizationDao get organization;
  NetworkServerDao get networkServer;
  ServerInfoDao get serverInfo;
}

class SupernodeDemoDao implements SupernodeDaoHolder {
  SupernodeDemoDao(this.client);
  final SupernodeHttpClient client;

  @override
  DemoDhxDao get dhx => DemoDhxDao();

  @override
  DemoGatewaysDao get gateways => DemoGatewaysDao();

  @override
  DemoStakeDao get stake => DemoStakeDao();

  @override
  DemoTopupDao get topup => DemoTopupDao();

  @override
  DemoUserDao get user => DemoUserDao();

  @override
  DemoWalletDao get wallet => DemoWalletDao();

  @override
  DemoWithdrawDao get withdraw => DemoWithdrawDao();

  @override
  DemoServerInfoDao get serverInfo => DemoServerInfoDao();

// No demo wrappers:
  @override
  GatewaysLocationDao get gatewaysLocation => GatewaysLocationDao(client);

  @override
  OrganizationDao get organization => OrganizationDao(client);

  @override
  NetworkServerDao get networkServer => NetworkServerDao(client);
}

class SupernodeMainDao implements SupernodeDaoHolder {
  SupernodeMainDao(this.client);
  final SupernodeHttpClient client;

  @override
  DhxDao get dhx => DhxDao(client);

  @override
  GatewaysDao get gateways => GatewaysDao(client);

  @override
  StakeDao get stake => StakeDao(client);

  @override
  TopupDao get topup => TopupDao(client);

  @override
  UserDao get user => UserDao(client);

  @override
  WalletDao get wallet => WalletDao(client);

  @override
  WithdrawDao get withdraw => WithdrawDao(client);

  @override
  GatewaysLocationDao get gatewaysLocation => GatewaysLocationDao(client);

  @override
  OrganizationDao get organization => OrganizationDao(client);

  @override
  NetworkServerDao get networkServer => NetworkServerDao(client);

  @override
  ServerInfoDao get serverInfo => ServerInfoDao(client);
}

class SupernodeRepository implements SupernodeDaoHolder {
  SupernodeDemoDao get demo => SupernodeDemoDao(client);
  SupernodeMainDao get main => SupernodeMainDao(client);

  final AppCubit appCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeHttpClient client;

  factory SupernodeRepository({
    AppCubit appCubit,
    SupernodeCubit supernodeCubit,
  }) {
    final dio = Dio();
    final headersInterceptor = SupernodeHeadersInterceptor(
      getToken: () => supernodeCubit.state?.user?.token,
      onLogOut: () => supernodeCubit.logout(),
      onTokenRefresh: (dio) => _refreshToken(dio, supernodeCubit),
      dio: dio,
    );
    final client = SupernodeHttpClient(
      getSupernode: () => supernodeCubit.state?.selectedNode,
      headersInterceptor: headersInterceptor,
      errorInterceptor: SupernodeErrorInterceptor(),
    );

    return SupernodeRepository._(appCubit, supernodeCubit, client);
  }

  SupernodeRepository._(this.appCubit, this.supernodeCubit, this.client);

  static SharedHttpClient _sharedClient([Dio dio]) =>
      SharedHttpClient(dio: dio);

  static Future<String> _refreshToken(
      Dio dio, SupernodeCubit supernodeCubit) async {
    final userInfo = supernodeCubit.state?.user;
    if (userInfo == null ||
        userInfo.username == null ||
        userInfo.password == null) return null;
    final username = userInfo.username;
    final password = userInfo.password;
    final res = await UserDao(_sharedClient(dio)).login(username, password);
    supernodeCubit.setSupernodeToken(res.jwt);
    return res.jwt;
  }

  Future<Map<String, Supernode>> loadSupernodes() {
    return SuperNodeGithubDao(_sharedClient()).superNodes();
  }

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

  @override
  OrganizationDao get organization => _currentHolder.organization;

  @override
  NetworkServerDao get networkServer => _currentHolder.networkServer;

  @override
  ServerInfoDao get serverInfo => _currentHolder.serverInfo;
}
