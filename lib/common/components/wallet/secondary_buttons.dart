import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/theme/colors.dart';

import '../row_spacer.dart';

Widget secondaryButtons({String buttonLabel1 = '',String buttonLabel2 = '',String buttonLabel3 = '',Function onTap1,Function onTap2,Function onTap3,int selectedIndex = 0}){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SecondaryButton(
          isSelected: selectedIndex == 0,
          buttonTitle: buttonLabel1,
          color: selectedIndex == 0 ? selectedTabColor : Colors.white,
          onTap: onTap1,
        ),
        smallRowSpacer(),
        SecondaryButton(
          isSelected: selectedIndex == 1,
          buttonTitle: buttonLabel2,
          color: selectedIndex == 1 ? selectedTabColor : Colors.white,
          onTap: onTap2,
        ),
        smallRowSpacer(),
        SecondaryButton(
          isSelected: selectedIndex == 2,
          buttonTitle: buttonLabel3,
          color: selectedIndex == 2 ? selectedTabColor : Colors.white,
          icon: Icons.date_range,
          onTap: onTap3,
        )
      ]
    )
  );
}