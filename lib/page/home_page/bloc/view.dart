import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/gateways_location_dao.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/common/daos/supernode_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/supernode_repository.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'state.dart';
import 'user/view.dart';
import 'user/state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: _HomePageContent(),
      providers: [
        BlocProvider(create: (ctx) => HomeCubit()),
        BlocProvider(
          create: (ctx) => UserCubit(
            userId: context.read<AppCubit>().state.supernode.userId,
            username: context.read<AppCubit>().state.supernode.username,
            orgId: context.read<AppCubit>().state.supernode.orgId,
            supernodeRepository: ctx.read<SupernodeRepository>(),
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
              default:
                throw UnimplementedError('Unknown tab ${s.tabIndex}');
            }
          }),
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
