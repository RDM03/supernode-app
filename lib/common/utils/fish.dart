import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class FishListener<T> {
  final Context<T> context;
  final void Function(Context<T>) callback;
  void listener() {
    callback(context);
  }

  FishListener(this.context, this.callback);
}
