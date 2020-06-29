import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/configs/images.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return Scaffold(
    body: Stack(
      children: <Widget>[
        viewService.buildComponent('user'),
        Stack(
          children: [
            Visibility(
              visible: Sys.mainMenus.indexOf('Home') == state.tabIndex,
              child: viewService.buildComponent('user')
            ),
            Visibility(
              visible: Sys.mainMenus.indexOf('Gateway') == state.tabIndex,
              child: viewService.buildComponent('gateway')
            ),
            Visibility(
              visible: Sys.mainMenus.indexOf('Device') == state.tabIndex,
              child: viewService.buildComponent('device')
            ),
            Visibility(
              visible: Sys.mainMenus.indexOf('Wallet') == state.tabIndex,
              child: viewService.buildComponent('wallet')
            )
          ]
          
          
          
          // Sys.mainMenus.map((String item) =>
          //   Visibility(
          //     visible: item == 'Home'? false : Sys.mainMenus.indexOf(item) == state.tabIndex,
          //     child: item == 'Home'? Container() : viewService.buildComponent(item.toLowerCase())
          //   )
          // ).toList()
        ),
        // Visibility(
        //   visible: state.loading,
        //   child: loading(),
        // ),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: state.tabIndex,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      onTap: (index) => dispatch(HomeActionCreator.tabIndex(index)),
      items: Sys.mainMenus.map((String item) =>     
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImages.bottomBarMenus[item.toLowerCase()],
            color: Sys.mainMenus.indexOf(item) == state.tabIndex ? selectedColor : unselectedColor,
          ),
          title: Text(
            FlutterI18n.translate(_ctx,item.toLowerCase()),
          ),
        ),
      ).toList()
    )
  );
}

