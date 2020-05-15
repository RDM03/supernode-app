import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget textfieldWithButton({String inputLabel = '',String hintText = '',String initialValue,TextEditingController controller,Function(String) validator,Function onTap,String buttonLabel,IconData icon,bool readOnly = false,bool autocorrect = true,bool isDivider = true,Widget suffixTitleChild}){
  return Container(
    padding: kOuterRowTop20,
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child:  Row(
            children: <Widget>[
              Visibility(
                visible: inputLabel.isNotEmpty,
                child: Text(
                  inputLabel,
                  style: kMiddleFontOfBlack,
                ),
              ),
              Spacer(),
              Visibility(
                visible: suffixTitleChild != null,
                child: suffixTitleChild ?? Container(),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  readOnly: readOnly,
                  autocorrect: autocorrect,
                  initialValue: initialValue,
                  decoration: InputDecoration(
                    contentPadding: kRoundRow105,
                    hintText: hintText,
                    border: InputBorder.none
                  ),
                  validator: validator,
                  controller: controller,
                )
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    border: Border( 
                      left: isDivider ?
                        BorderSide(
                          width: 1,
                          color: Colors.grey
                        ) :
                        BorderSide.none
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          icon,
                          size: 30,
                        ),
                      ),
                      Visibility(
                        visible: buttonLabel != null,
                        child: Text(
                          buttonLabel ?? '',
                          textAlign: TextAlign.left,
                          style: kSmallFontOfGrey,
                        )
                      )
                    ]
                  ),
                )
              )
            ],
          ),
        )
      ]
    )
  );
}