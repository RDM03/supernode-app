import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultFailure extends StatelessWidget {
  final String detail;

  const DDResultFailure({Key key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: FlutterI18n.translate(context, 'adding_miner_failure_title'),
      detail:
          '${FlutterI18n.translate(context, "adding_miner_failure_detail")}\n\n[Detail: $detail]',
      imageUrl: AppImages.addMinerFailure,
      buttonText: FlutterI18n.translate(context, 'back'),
    );
  }
}
