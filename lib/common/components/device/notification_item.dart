import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class NotificationItem extends StatelessWidget {
  final VoidCallback onTap;

  const NotificationItem({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 7,
                  color: boxShadowColor,
                )
              ]),
          child: ListTile(
            title: Text(
              '2020-05-20 09:39:12 14km -135dBm',
              style: kMiddleFontOfGrey,
            ),
            trailing: Image.asset(
              'assets/images/device/location_warn.png',
              width: 22,
            ),
          ),
        ),
      ),
    );
  }
}
