import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget dateButtons(
  BuildContext context, {
  String firstTime,
  String secondTime,
  String thirdText,
  Function(String) firstTimeOnTap,
  Function(String) secondTimeOnTap,
  Function onSearch,
}) {
  return Container(
    // scrollDirection: Axis.horizontal,
    // physics: const NeverScrollableScrollPhysics(),
    // contentPadding: EdgeInsets.zero,
    // child: Container(
    height: 34,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 135,
          child: SecondaryButton(
            color: ColorsTheme.of(context).secondaryBackground,
            buttonTitle: firstTime ?? '',
            icon: Icons.date_range,
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(2000),
                      lastDate: new DateTime.now())
                  .then((DateTime value) {
                if (value != null) {
                  firstTimeOnTap(TimeUtil.getDatetime(value, type: 'date'));
                }
              });
            },
          ),
        ),
        Container(
          padding: kRoundRow5,
          alignment: Alignment.center,
          child: Text('~'),
        ),
        SizedBox(
          width: 135,
          child: SecondaryButton(
            color: ColorsTheme.of(context).secondaryBackground,
            buttonTitle: secondTime ?? '',
            icon: Icons.date_range,
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: firstTime != null
                          ? DateTime.parse(firstTime)
                          : new DateTime(2000),
                      lastDate: new DateTime.now())
                  .then(
                (DateTime value) {
                  if (value != null) {
                    secondTimeOnTap(TimeUtil.getDatetime(value, type: 'date'));
                  }
                },
              );
            },
          ),
        ),
        SizedBox(width: 15),
        Center(
          child: GestureDetector(
            child: Text(
              thirdText ?? '',
              style: kMiddleFontOfGreyLink,
            ),
            onTap: onSearch,
          ),
        ),
        SizedBox(width: 15),
      ],
    ),
  );
}
