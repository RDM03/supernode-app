import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class FootPrintsItem extends StatelessWidget {
  final VoidCallback onTap;

  const FootPrintsItem({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: ColorsTheme.of(context).boxComponents,
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
              style: FontTheme.of(context).middle.secondary(),
            ),
            trailing: Icon(
              Icons.location_on,
              size: 22,
              color: dbm120,
            ),
          ),
        ),
      ),
    );
  }
}
