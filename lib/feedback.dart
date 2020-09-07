import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/theme/font.dart';

class DatadashFeedbackWidgetForm extends StatefulWidget {
  const DatadashFeedbackWidgetForm(this.translation, this.sendFeedback);
  final FeedbackTranslation translation;
  final void Function(String text) sendFeedback;

  @override
  _DatadashFeedbackWidgetFormState createState() =>
      _DatadashFeedbackWidgetFormState();
}

class _DatadashFeedbackWidgetFormState
    extends State<DatadashFeedbackWidgetForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(26, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: double.infinity,
                    child: Text(
                      widget.translation.feedbackDescriptionText,
                      style: kMiddleFontOfBlack,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryTextField(
                      key: const Key('feedbackTextfield'),
                      hint: '',
                      controller: textEditingController,
                    ),
                  ),
                  SizedBox(height: 15),
                  PrimaryButton(
                    key: const Key('submit_feedback_button'),
                    buttonTitle: widget.translation.submitButtonText,
                    onTap: () => widget.sendFeedback(
                      textEditingController.text,
                    ),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  BetterFeedback.of(context).hide();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatadashTranslation extends FeedbackTranslation {
  final BuildContext Function() context;
  DatadashTranslation(this.context);

  String _translate(String key) {
    final ctx = context();
    if (ctx == null) return 'loading...';
    return FlutterI18n.translate(context(), key);
  }

  @override
  String get draw => _translate('draw');

  @override
  String get feedbackDescriptionText => _translate('whats_up');

  @override
  String get navigate => '???';

  @override
  String get submitButtonText => _translate('done');
}
