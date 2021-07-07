import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

class SupernodeButton extends StatelessWidget {
  SupernodeButton({this.cardChild, this.onPress, this.selected = false});

  // final Color colour;
  final Widget cardChild;
  final Function onPress;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 90,
        height: 36,
        child: cardChild,
        padding: kRoundRow2,
        margin: const EdgeInsets.only(top: 10.0, right: 20.0, bottom: 10.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
              color: selected ? buttonPrimaryColor : greyColor,
              width: selected ? 2 : 0.5),
          // boxShadow: [
          //   BoxShadow(
          //     color: selected ? buttonPrimaryColor : greyColor,
          // blurRadius: selected ? 0.0 : 2.0, // has the effect of softening the shadow
          // spreadRadius: 0.5, // has the effect of extending the shadow
          // offset: Offset(
          //   selected ? 0 : 1.5, // horizontal, move right 10
          //   selected ? 0 : 1.5, // vertical, move down 10
          // ),
          //   )
          // ]
        ),
      ),
    );
  }
}
