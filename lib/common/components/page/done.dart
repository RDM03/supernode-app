import 'package:flutter/material.dart';

Widget done({bool success = true, Color color}) {
  return Center(
    child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Icon(
          success ? Icons.check_circle_outline : Icons.info_outline,
          color: color ?? (success ? Colors.green : Colors.blue),
          size: 80,
          key: Key('successIcon_$success'),
        )),
  );
}
