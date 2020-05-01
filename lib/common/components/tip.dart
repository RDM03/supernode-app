import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void tip(context, text,{bool success: false}){
   Toast.show(text.runtimeType == String ? text : text.toString(), context, duration: 3, gravity: Toast.BOTTOM, backgroundColor: success ? Colors.green : Colors.red[200]);
}