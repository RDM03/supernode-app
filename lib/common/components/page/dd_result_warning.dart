import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultWarning extends StatelessWidget {
  final String detail;

  const DDResultWarning({Key key, this.detail = 'No more information'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: 'Note : This miner is used one',
      detail:
          'Used miners function differently than new miners. If you didn’t intend to purchase a used miner, please contact the person who sold it to you. \n\n [Detail: $detail]',
      imageUrl: AppImages.addMinerWarning,
      buttonText: 'done',
    );
  }
}
