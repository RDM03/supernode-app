import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TabComponentState extends ComponentState<WalletState>
    with SingleTickerProviderStateMixin {}

class TabComponent extends Component<WalletState> {
  @override
  TabComponentState createState() => TabComponentState();
}

class WalletComponent extends Component<WalletState> {
  WalletComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );

  @override
  ComponentState<WalletState> createState() {
    return TabComponentState();
  }
}
