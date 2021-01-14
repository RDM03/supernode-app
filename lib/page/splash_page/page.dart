import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class SplashPage extends Page<SplashState, Map<String, dynamic>>{
  SplashPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            view: buildView);
}
