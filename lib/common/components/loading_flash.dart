import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingFlash({Widget child}){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    child: child
  );
}