import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'package:supernodeapp/widgets/text_field/primary_text_field.dart';

class TextFieldWithTitle extends StatelessWidget {
  TextFieldWithTitle(
      {@required this.title,
      @required this.hint,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.done});

  final String title;
  final String hint;
  final bool isObscureText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: kTitleTextStyle1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: PrimaryTextField(
              hint: hint,
              isObscureText: isObscureText,
              textInputAction: textInputAction
          ),
        )
      ],
    );
  }
}
