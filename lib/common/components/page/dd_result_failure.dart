import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supernodeapp/configs/images.dart';

import 'dd_result.dart';

class DDResultFailure extends StatelessWidget {
  final String detail;

  const DDResultFailure({Key key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DDResult(
      title: 'Oops! something went wrong',
      detail:
          'That didn’t quite work, please try again. \n\n [Detail: $detail]',
      imageUrl: AppImages.addMinerFailure,
      buttonText: 'back',
    );
  }
}
