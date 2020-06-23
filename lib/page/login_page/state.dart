import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/data/super_nodes_bean.dart';
import 'package:supernodeapp/global_store/store.dart';

class LoginState implements Cloneable<LoginState> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  bool isObscureText = true;
  bool showSuperNodeList = false;
  Map<String, List<SuperNodeBean>> superNodes;
  SuperNodeBean currentSuperNode;

  @override
  LoginState clone() {
    return LoginState()
      ..superNodes = superNodes
      ..showSuperNodeList = showSuperNodeList
      ..isObscureText = isObscureText
      ..currentSuperNode = currentSuperNode
      ..formKey = formKey
      ..usernameCtl = usernameCtl
      ..passwordCtl = passwordCtl;
  }
}

LoginState initState(Map<String, dynamic> args) {
  return LoginState()..superNodes = GlobalStore.state.superModel.superNodesByCountry;
}
