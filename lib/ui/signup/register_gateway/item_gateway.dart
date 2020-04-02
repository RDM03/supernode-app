

import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/theme/colors.dart';

class ItemGateway extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 76),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(26, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ],
        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 44,
              height: 44,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: iconCircularBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 22,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      "assets/images/gateway.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 109,
            height: 45,
            margin: EdgeInsets.only(left: 12, top: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 21,
                  child: Text(
                    "xxx-xxx-xxx-xxx",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 77, 137, 229),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Text(
                    "Gateway",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(222, 0, 0, 0),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}