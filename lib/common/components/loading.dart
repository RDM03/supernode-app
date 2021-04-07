import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/theme/colors.dart';

class Loading {
  bool _enabled = true;
  bool get enabled => _enabled;

  final BuildContext _loadingContext;

  Loading._(this._loadingContext);

  static Loading show(BuildContext context) {
    context.read<AppCubit>().setLoading(true);
    return Loading._(context);
  }

  void hide() {
    _loadingContext.read<AppCubit>().setLoading(false);
  }
}

Widget loadingView() {
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitPulse(
          color: buttonPrimaryColor,
          size: 50.0,
        ),
      ),
    ),
  );
}
