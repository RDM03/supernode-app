import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:supernodeapp/common/components/map_box.dart';
import 'package:supernodeapp/common/components/page/drag_page.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/border_prompt_component/state.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/discover_component/state.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/discovery_border_component/state.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/footprints_location_component/state.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/notification_out_component/state.dart';

import 'footprints_component/state.dart';
import 'introduction_component/state.dart';
import 'notification_component/state.dart';

enum TabDetailPageEnum { Discovery, Footprints, Notification }

class DeviceMapBoxState implements Cloneable<DeviceMapBoxState> {
  MapViewController mapCtl = MapViewController();
  bool showIntroduction = true;
  bool showSetBorderPrompt = false;
  bool showDragFrontWidget = false;
  String userGroupValue = 'Me';
  String genderGroupValue = 'Male';
  PageController introPageController = new PageController();
  PageController bottomPageController = new PageController();
  int selectTabIndex = 0;
  GlobalKey<DragPageState> dragPageState = new GlobalKey();
  TabDetailPageEnum showTabDetailName;
  double gatewaySliderValue = 0;
  LatLng centerPoint = LatLng(37.386, -122.083);
  int footPrintsType = 0;

  TextEditingController ageController = new TextEditingController();

  @override
  DeviceMapBoxState clone() {
    return DeviceMapBoxState()
      ..mapCtl = mapCtl
      ..showIntroduction = showIntroduction
      ..showSetBorderPrompt = showSetBorderPrompt
      ..showDragFrontWidget = showDragFrontWidget
      ..userGroupValue = userGroupValue
      ..genderGroupValue = genderGroupValue
      ..introPageController = introPageController
      ..bottomPageController = bottomPageController
      ..selectTabIndex = selectTabIndex
      ..dragPageState = dragPageState
      ..showTabDetailName = showTabDetailName
      ..gatewaySliderValue = gatewaySliderValue
      ..ageController = ageController
      ..centerPoint = centerPoint
      ..footPrintsType = footPrintsType;
  }
}

DeviceMapBoxState initState(Map<String, dynamic> args) {
  return DeviceMapBoxState()..mapCtl = MapViewController();
}

class IntroductionConnector
    extends ConnOp<DeviceMapBoxState, IntroductionState> {
  @override
  IntroductionState get(DeviceMapBoxState state) {
    return IntroductionState()
      ..userGroupValue = state.userGroupValue
      ..genderGroupValue = state.genderGroupValue
      ..pageController = state.introPageController
      ..ageController = state.ageController;
  }

  @override
  void set(DeviceMapBoxState state, IntroductionState subState) {
    state.userGroupValue = subState.userGroupValue;
    state.genderGroupValue = subState.genderGroupValue;
    state.introPageController = subState.pageController;
    state.ageController = subState.ageController;
  }
}

class DiscoverConnector extends ConnOp<DeviceMapBoxState, DiscoverState> {
  @override
  DiscoverState get(DeviceMapBoxState state) {
    return DiscoverState();
  }

  @override
  void set(DeviceMapBoxState state, DiscoverState subState) {}
}

class FootprintsConnector extends ConnOp<DeviceMapBoxState, FootprintsState> {
  @override
  FootprintsState get(DeviceMapBoxState state) {
    return FootprintsState()..footPrintsType = state.footPrintsType;
  }

  @override
  void set(DeviceMapBoxState state, FootprintsState subState) {
    state.footPrintsType = subState.footPrintsType;
  }
}

class NotificationConnector
    extends ConnOp<DeviceMapBoxState, NotificationState> {
  @override
  NotificationState get(DeviceMapBoxState state) {
    return NotificationState();
  }

  @override
  void set(DeviceMapBoxState state, NotificationState subState) {}
}

class DiscoverBorderConnector
    extends ConnOp<DeviceMapBoxState, DiscoveryBorderState> {
  @override
  DiscoveryBorderState get(DeviceMapBoxState state) {
    return DiscoveryBorderState()
      ..gatewaySliderValue = state.gatewaySliderValue;
  }

  @override
  void set(DeviceMapBoxState state, DiscoveryBorderState subState) {
    state.gatewaySliderValue = subState.gatewaySliderValue;
  }
}

class FootPrintsLocationConnector
    extends ConnOp<DeviceMapBoxState, FootPrintsLocationState> {
  @override
  FootPrintsLocationState get(DeviceMapBoxState state) {
    return FootPrintsLocationState()..mapCtl = state.mapCtl;
  }

  @override
  void set(DeviceMapBoxState state, FootPrintsLocationState subState) {
    state.mapCtl = subState.mapCtl;
  }
}

class NotificationOutConnector
    extends ConnOp<DeviceMapBoxState, NotificationOutState> {
  @override
  NotificationOutState get(DeviceMapBoxState state) {}

  @override
  void set(DeviceMapBoxState state, NotificationOutState subState) {}
}

class BorderPromptConnector
    extends ConnOp<DeviceMapBoxState, BorderPromptState> {
  @override
  BorderPromptState get(DeviceMapBoxState state) {
    return BorderPromptState();
  }

  @override
  void set(DeviceMapBoxState state, BorderPromptState subState) {}
}
