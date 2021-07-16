import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class TitleDetailRow extends StatelessWidget {
  final String name;
  final dynamic value;
  final bool loading;
  final String token;
  final bool disabled;

  const TitleDetailRow({
    Key key,
    this.name = '',
    this.value,
    this.loading = false,
    this.token = 'MXC',
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow1505,
      child: Row(
        children: <Widget>[
          Text(
            name,
            textAlign: TextAlign.left,
            style: FontTheme.of(context).small.secondary(),
          ),
          Spacer(),
          loading
              ? loadingFlash(
                  child: Text(
                  '$value $token',
                  textAlign: TextAlign.left,
                  style: FontTheme.of(context).big(),
                ))
              : Text(
                  '$value${token.isNotEmpty ? ' $token' : ''}',
                  textAlign: TextAlign.left,
                  style: disabled
                      ? FontTheme.of(context).big.secondary()
                      : FontTheme.of(context).big(),
                )
        ],
      ),
    );
  }
}
