import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supernodeapp/theme/colors.dart';

bool isLoadingLarge = false;

void showLoading(BuildContext context) {
  isLoadingLarge = true;
  showCupertinoDialog(
    context: context,
    builder: (context){
      return loadingView();
    }
  );
}

void hideLoading(BuildContext context) {
  if(isLoadingLarge) {
    Navigator.of(context).pop();
    isLoadingLarge = false;
  }
}

Widget loadingView(){
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitWave(
          color: buttonPrimaryColor,
          size: 50.0,
        )
//        CircularProgressIndicator(
          // backgroundColor: Colors.black,
//          strokeWidth: 2,
//        )
      ),
    )
  );
}