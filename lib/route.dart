import 'package:flutter/material.dart';

MaterialPageRoute route(WidgetBuilder builder) =>
    MaterialPageRoute(builder: builder);

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
