import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class TitleDetailRow extends StatelessWidget {
  final String name;
  final dynamic value;
  final bool loading;
  final String token;
  final bool disabled;
  final Widget trail;

  const TitleDetailRow({
    Key key,
    this.name = '',
    this.value,
    this.loading = false,
    this.token = 'MXC',
    this.disabled = false,
    this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kRoundRow15_5,
      child: Row(
        children: <Widget>[
          Text(
            name,
            textAlign: TextAlign.left,
            style: kSmallFontOfGrey,
          ),
          Spacer(),
          loading
              ? loadingFlash(
                  child: Text(
                  '$value $token',
                  textAlign: TextAlign.left,
                  style: kBigFontOfBlack,
                ))
              : Text(
                  '$value${token.isNotEmpty ? ' $token' : ''}',
                  textAlign: TextAlign.left,
                  style: disabled ? kBigFontOfGrey : kBigFontOfBlack,
                ),
          trail != null ? trail : SizedBox()
        ],
      ),
    );
  }
}
