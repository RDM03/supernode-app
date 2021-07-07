import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultWarning extends StatelessWidget {
  final String detail;

  const DDResultWarning({Key key, this.detail = 'No more information'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: FlutterI18n.translate(context, 'adding_miner_warning_title'),
      detail:
          '${FlutterI18n.translate(context, "adding_miner_warning_detail")}\n\n [Detail: $detail]',
      imageUrl: AppImages.addMinerWarning,
      buttonText: FlutterI18n.translate(context, 'done'),
    );
  }
}
