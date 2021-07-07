import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

Future<void> selectPicker(
  context, {
  List data,
  int value = -1,
  Function onSelected,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return Container(
        height: 200.0,
        child: Stack(
          children: [
            CupertinoPicker(
              backgroundColor: whiteColor,
              itemExtent: 58.0,
              scrollController: FixedExtentScrollController(initialItem: value),
              children: data != null
                  ? data
                      .map((item) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('$item')))
                      .toList()
                  : [],
              onSelectedItemChanged: (int index) {
                if (onSelected != null) {
                  onSelected(index);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
