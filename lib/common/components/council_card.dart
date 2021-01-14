import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/font.dart';

class CouncilCard extends StatelessWidget {
  final Council council;
  final VoidCallback onTap;

  const CouncilCard({
    Key key,
    this.council,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10)),
                  color: Color(0xFF4665EA),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.landmark,
                    color: Colors.white,
                  ),
                ),
                width: 56,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      council.name,
                      style: kBigFontOfBlue,
                    ),
                    Text(
                      '${FlutterI18n.translate(context, 'latest_mpower')} : ${Tools.numberRounded(Tools.convertDouble(council.lastMpower))}',
                      style: kMiddleFontOfBlack,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
