import 'package:flutter/cupertino.dart';

void selectPicker(context,{List data, int value = -1,Function onSelected}){
  showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return Container(
        height: 200.0,
        child: CupertinoPicker(
          itemExtent: 58.0,
          scrollController: FixedExtentScrollController(
            initialItem: value
          ),
          children: data != null ? 
            data.map((item) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('$item'))
            ).toList() : [],
          onSelectedItemChanged: (int index){
            if(onSelected != null){
              onSelected(index);
            }
          }
        ),
      );
    }
  );
}