import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Page;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SplashPage extends Page<SplashState, Map<String, dynamic>>{
  SplashPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SplashState>(
                adapter: null,
                slots: <String, Dependent<SplashState>>{
                }),
            middleware: <Middleware<SplashState>>[
            ],);

  @override
  ComponentState<SplashState> createState() {
    return SplashSingleTickerProviderState();
  }
}

class SplashSingleTickerProviderState extends ComponentState<SplashState>
    with SingleTickerProviderStateMixin {
}

