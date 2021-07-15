import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget loadingFlash({Widget child}) {
  return Shimmer.fromColors(
    baseColor: greyColorShade300,
    highlightColor: greyColorShade100,
    child: child,
  );
}

Widget loadableWidget({bool loading: false, Widget child}) {
  return (loading) ? loadingFlash(child: child) : child;
}
