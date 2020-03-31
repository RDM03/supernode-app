import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBars{

  static signUpAppBar({Map Function() onPress}){
    return AppBar(
      leading: IconButton(
        onPressed: onPress ,
        icon: Image.asset("assets/images/arrow-left.png",),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
