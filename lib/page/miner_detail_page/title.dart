import 'package:flutter/material.dart';

import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class MinerDetailTitle extends StatelessWidget {
  final String text;
  final Widget action;

  const MinerDetailTitle(
    this.text, {
    Key key,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: FontTheme.of(context).big(),
              ),
            ),
            if (action != null) action
          ],
        ),
      ),
    );
  }
}
