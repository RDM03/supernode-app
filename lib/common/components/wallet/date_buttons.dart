import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget dateButtons(BuildContext context,{String firstTime,String secondTime,String thirdText,Function(String) firstTimeOnTap,Function(String) secondTimeOnTap,Function onSearch}){
  return Container(
    // scrollDirection: Axis.horizontal,
    // physics: const NeverScrollableScrollPhysics(),
    // contentPadding: EdgeInsets.zero,
    // child: Container(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SecondaryButton(
          color: Colors.white,
          buttonTitle: firstTime ?? '',
          icon: Icons.date_range,
          onTap: (){
            showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime(2000),
              lastDate: new DateTime.now()
            ).then((DateTime value) {
              if(value != null){
                firstTimeOnTap(TimeDao.getDatetime(value,type: 'date'));
              }
            });
          },
        ),
        Container(
          padding: kRoundRow5,
          child: Text('~'),
        ),
        SecondaryButton(
          color: Colors.white,
          buttonTitle: secondTime ?? '',
          icon: Icons.date_range,
          onTap: (){
            showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: firstTime != null ? DateTime.parse(firstTime) : new DateTime(2000),
              lastDate: new DateTime.now()
            ).then((DateTime value){
              if(value != null){
                secondTimeOnTap(TimeDao.getDatetime(value,type: 'date'));
              }
            });
          },
        ),
        Spacer(),
        GestureDetector(
          child: Text(
            thirdText ?? '',
            style: kMiddleFontOfGreyLink,
          ),
          onTap: onSearch,
        )
      ]
    ),
  );
}