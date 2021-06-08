import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultSuccss extends StatelessWidget {
  const DDResultSuccss({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: 'Congratulations!',
      detail: 'Your M2 Pro Miner is now mining!!!',
      imageUrl: AppImages.addMinerSuccess,
      buttonText: 'done',
    );
  }
}
