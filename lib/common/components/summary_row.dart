import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class SummaryRow extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String number;
  final String price;
  final bool loading;

  const SummaryRow({
    Key key,
    this.image = '',
    this.title = '',
    this.subtitle = '',
    this.number = '',
    this.price = '',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = price.split('(');
    String mxcPrice;
    String usdPrice;
    if (temp.length == 1) {
      usdPrice = price;
      mxcPrice = '';
    } else {
      mxcPrice = temp[0].substring(0, temp[0].length - 1);
      print(mxcPrice);
      usdPrice = temp[1].substring(0, temp[1].length - 1);
    }

    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.blueCircle,
            fit: BoxFit.none,
            color: lightBlue,
          ),
          Image.asset(
            image,
            fit: BoxFit.none,
          )
        ],
      ),
      title: Text(
        title,
        style: kMiddleFontOfBlack,
      ),
      subtitle: loading
          ? loadingFlash(
              child: Text(
              number,
              style: kBigFontOfBlue,
            ))
          : Text(
              number,
              style: kBigFontOfBlue,
            ),
      trailing: Container(
        margin: kOuterRowTop10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              subtitle,
              style: kSmallFontOfGrey,
            ),
            loading
                ? loadingFlash(
                    child: Text(
                    '≈ ' + usdPrice,
                    style: kMiddleFontOfBlack,
                  ))
                : Text(
                    '≈ ' + usdPrice,
                    key: key,
                    style: kMiddleFontOfBlack,
                  )
          ],
        ),
      ),
    );
  }
}
