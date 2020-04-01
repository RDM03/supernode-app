import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/main.dart';
import 'package:supernodeapp/ui/login/login_route.dart';
import 'package:supernodeapp/ui/signup/code_verification/sign_up_verification_code_route.dart';
import 'package:supernodeapp/ui/signup/profile/sign_up_profile_route.dart';
import 'package:supernodeapp/ui/splash/splash_route.dart';
import 'route.dart';
import 'ui/signup/welcome/sign_up_welcome_route.dart';

class RouterService {
  static RouterService get instance => RouterService();

  factory RouterService() => _singleton;
  static final RouterService _singleton = RouterService._init();

  static final List<ARoute> routes = [
    SplashRoute(),
    LogInRoute(),
    SignUpWelcomeRoute(),
    SignUpVerificationRoute(),
    SignUpProfileRoute(),
  ];

  final Router _router = Router();

  RouterService._init() {
    for (var route in routes) {
      _router.define(
        route.path,
        handler: Handler(handlerFunc: route.handlerFunc),
        transitionType: route.transition,
      );
    }
  }

  Route<dynamic> generator(RouteSettings routeSettings) =>
      _router.generator(routeSettings);

  void pop(BuildContext context) => _router.pop(context);

  Future<dynamic> navigateTo(
    String path, {
    bool replace,
    bool clearStack,
    TransitionType transition,
    Duration transitionDuration,
    RouteTransitionsBuilder transitionBuilder,
    BuildContext context,
  }) async {
    final match = _router.match(path);
    if (match != null) {
      final route = routes.firstWhere((r) => r.path == match.route.route);
      final hasPermission = await route.hasPermission(match.parameters);
      if (hasPermission) {
        if (context != null) {
          return _router.navigateTo(
            context,
            path,
            replace: replace ?? route.replace,
            clearStack: clearStack ?? route.clearStack,
            transition: transition ?? route.transition,
            transitionDuration: transitionDuration ?? route.transitionDuration,
            transitionBuilder: transitionBuilder ?? route.transitionBuilder,
          );
        } else if (clearStack ?? route.clearStack) {
          return MyApp.navigatorKey.currentState
              .pushNamedAndRemoveUntil(path, (check) => false);
        } else if (replace ?? route.replace) {
          return MyApp.navigatorKey.currentState.pushReplacementNamed(path);
        } else {
          return MyApp.navigatorKey.currentState.pushNamed(path);
        }
      }
    }
  }
}
