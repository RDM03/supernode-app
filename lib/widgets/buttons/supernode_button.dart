import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupernodeButton extends StatelessWidget {
  SupernodeButton({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 36,
        child: cardChild,
        margin: EdgeInsets.only(top:10.0,right: 20.0),
        decoration: BoxDecoration(
          color: colour,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
              offset: Offset(
                1.5, // horizontal, move right 10
                1.5, // vertical, move down 10
              ),
            )
          ]
        ),
      ),
    );
  }
}
