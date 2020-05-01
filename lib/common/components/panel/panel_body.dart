import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget panelBody({String titleText,String subtitleText,String trailTitle, trailSubtitle,IconData icon,Function onPressed}){
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
      margin: const EdgeInsets.only(left: 10),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          color: buttonPrimaryColor,
          size: 50,
        ),
        onPressed: onPressed,
      )
    ),
    title: Text(
      titleText,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Color.fromARGB(222, 0, 0, 0),
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
      ),
    ),
    subtitle: Text(
      subtitleText,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Color.fromARGB(255, 77, 137, 229),
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
      ),
    ),
    trailing: Container(
      margin: EdgeInsets.only(top: 10, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            trailTitle,
            style: TextStyle(
              color: Color.fromARGB(138, 0, 0, 0),
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.33333,
            ),
          ),
          Text(
            trailSubtitle,
            style: TextStyle(
              color: Color.fromARGB(222, 0, 0, 0),
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5,
            ),
          )
        ]
      )
    )
  );
}