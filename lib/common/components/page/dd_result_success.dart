import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultSuccss extends StatelessWidget {
  const DDResultSuccss({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: '${FlutterI18n.translate(context, "congratulation")}!',
      detail: '${FlutterI18n.translate(context, "adding_miner_success_detail")}!!!',
      imageUrl: AppImages.addMinerSuccess,
      buttonText: FlutterI18n.translate(context, 'done'),
    );
  }
}
