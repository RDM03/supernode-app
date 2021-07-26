import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'dd_icon_with_shadow.dart';

class DDIconWithTitles extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const DDIconWithTitles(
      {Key key, @required this.imageUrl, @required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow2010,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DDIconWithShadow(
                imageUrl: imageUrl,
              ),
              DDBoxSpacer(width: SpacerStyle.medium),
              Container(
                padding: kOuterRowTop10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(FlutterI18n.translate(context, title),
                        style: FontTheme.of(context).big.primary.bold()),
                    Text(
                      FlutterI18n.translate(context, subtitle),
                      style: FontTheme.of(context).middle(),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
