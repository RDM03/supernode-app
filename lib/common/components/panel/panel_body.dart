import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class PanelBody extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final String trailTitle;
  final Key keyIcon;
  final Key keyTitle;
  final Key keySubtitle;
  final Key keyTrailSubtitle;
  final String trailSubtitle;
  final IconData icon;
  final Function onPressed;
  final bool loading;
  final bool trailLoading;

  const PanelBody({
    Key key,
    this.titleText,
    this.subtitleText,
    this.trailTitle,
    this.keyIcon,
    this.keyTitle,
    this.keySubtitle,
    this.keyTrailSubtitle,
    this.trailSubtitle,
    this.icon,
    this.onPressed,
    this.trailLoading,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = trailSubtitle.split('(');
    final mxcPrice = temp[0].substring(0, temp[0].length - 1);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
            key: keyIcon,
            padding: EdgeInsets.zero,
            icon: Icon(
              icon,
              color: buttonPrimaryColor,
              size: 50,
            ),
            onPressed: onPressed,
          )),
      title: Text(
        titleText,
        key: keyTitle,
        textAlign: TextAlign.left,
        style: kMiddleFontOfBlack,
      ),
      subtitle: loading
          ? loadingFlash(
              child: Text(
                subtitleText,
                textAlign: TextAlign.left,
                style: kBigFontOfBlack,
              ),
            )
          : Text(
              subtitleText,
              key: keySubtitle,
              textAlign: TextAlign.left,
              style: kBigFontOfBlack,
            ),
      trailing: Container(
        margin: EdgeInsets.only(top: 10, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(trailTitle, style: kSmallFontOfGrey),
            (trailLoading ?? loading)
                ? loadingFlash(
                    child: Text(
                      mxcPrice,
                      style: kMiddleFontOfBlack,
                    ),
                  )
                : Text(
                    mxcPrice,
                    key: keyTrailSubtitle,
                    style: kMiddleFontOfBlack,
                  )
          ],
        ),
      ),
    );
  }
}
