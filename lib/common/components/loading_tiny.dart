
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loading({bool isSmall = false}){
  return isSmall ? 
  indicatior():
  Scaffold(
    backgroundColor: Colors.transparent,
    body: indicatior()
  );
}

Widget indicatior(){
  return Center(
    child: SizedBox(
      width: 30,
      height: 30,
      child: CupertinoActivityIndicator()
    )     
  );
}