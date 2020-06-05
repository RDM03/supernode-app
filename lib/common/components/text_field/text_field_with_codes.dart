import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import 'text_field_with_title.dart';

Widget textfieldWithCodes({BuildContext context,TextEditingController controller,bool isLast = false}){
  return SizedBox(
    width: 40,
    child: TextFieldWithTitle(
      title: '',
      // maxLength: 1,
      counterText: '',
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value){
        controller.text = value.substring(value.length - 1);
        if(value.length > 0 && !isLast){
          FocusScope.of(context).nextFocus();
        }else{
          FocusScope.of(context).unfocus();
        }
      },
      validator: (value) => Reg.onValidNumber(context,value,isShowError: false),
      controller: controller,
    ),
  );
}