import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/main.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/btc/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/wallet/cubit.dart';
import 'package:supernodeapp/page/home_page/device/view.dart';
import 'package:supernodeapp/page/home_page/gateway/view.dart';
import 'package:supernodeapp/page/home_page/wallet/view.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'cubit.dart';
import 'state.dart';
import 'bloc/supernode/user/cubit.dart';
import 'user/view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: WillPopScope(
        onWillPop: () async {
          if (homeNavigatorKey.currentState.canPop()) {
            homeNavigatorKey.currentState.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: homeNavigatorKey,
          onPopPage: (route, result) {
            return route.didPop(result);
          },
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return MxcApp.fishRoutes
                    .buildPage(settings.name, settings.arguments);
              },
              settings: settings,
            );
          },
          onGenerateInitialRoutes: (state, s) => [
            route((ctx) => BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (a, b) => a.language != b.language,
                builder: (ctx, s) =>  _HomePageContent())),
          ],
        ),
      ),
      providers: [
        BlocProvider(
          create: (ctx) => HomeCubit(
            username: ctx.read<SupernodeCubit>().state.session.username,
            cacheRepository: ctx.read<CacheRepository>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => SupernodeUserCubit(
            session: ctx.read<SupernodeCubit>().state.session,
            orgId: ctx.read<SupernodeCubit>().state.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
            cacheRepository: ctx.read<CacheRepository>(),
            homeCubit: ctx.read<HomeCubit>(),
          )..initState(),
        ),
        BlocProvider(
          create: (ctx) => SettingsCubit(
            appCubit: ctx.read<AppCubit>(),
            supernodeUserCubit: ctx.read<SupernodeUserCubit>(),
            supernodeRepository: ctx.read<SupernodeRepository>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => SupernodeDhxCubit(
            session: ctx.read<SupernodeCubit>().state.session,
            orgId: ctx.read<SupernodeCubit>().state.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
            cacheRepository: ctx.read<CacheRepository>(),
            homeCubit: ctx.read<HomeCubit>(),
          )..initState(),
        ),
        BlocProvider(
          create: (ctx) => SupernodeBtcCubit(
            session: ctx.read<SupernodeCubit>().state.session,
            orgId: ctx.read<SupernodeCubit>().state.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
            homeCubit: ctx.read<HomeCubit>(),
          )..initState(),
        ),
        BlocProvider(
          create: (ctx) => WalletCubit(
            orgId: ctx.read<SupernodeCubit>().state.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
            cacheRepository: ctx.read<CacheRepository>(),
            homeCubit: ctx.read<HomeCubit>(),
          )..initState(),
        ),
        BlocProvider(
          create: (ctx) => GatewayCubit(
            orgId: ctx.read<SupernodeCubit>().state.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
            homeCubit: ctx.read<HomeCubit>(),
          )..initState(),
        ),
      ],
    );
  }
}

class _HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (a, b) => a.tabIndex != b.tabIndex,
        builder: (ctx, s) {
          switch (s.tabIndex) {
            case 0:
              return UserTab();
            case 1:
              return GatewayTab();
            case 2:
              return DeviceTab();
            case 3:
              return WalletTab();
            default:
              throw UnimplementedError('Unknown tab ${s.tabIndex}');
          }
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) => a.tabIndex != b.tabIndex,
          builder: (ctx, s) => BottomNavigationBar(
            key: ValueKey('bottomNavBar'),
            type: BottomNavigationBarType.fixed,
            currentIndex: s.tabIndex,
            selectedItemColor: selectedColor,
            unselectedItemColor: unselectedColor,
            onTap: (i) => context.read<HomeCubit>().changeTab(i),
            items: Sys.mainMenus
                .map(
                  (String item) => BottomNavigationBarItem(
                    icon: Image.asset(
                      AppImages.bottomBarMenus[item.toLowerCase()],
                      color: Sys.mainMenus.indexOf(item) == s.tabIndex
                          ? selectedColor
                          : unselectedColor,
                      key: ValueKey('bottomNavBar_$item'),
                    ),
                    title: Text(
                      FlutterI18n.translate(ctx, item.toLowerCase()),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
