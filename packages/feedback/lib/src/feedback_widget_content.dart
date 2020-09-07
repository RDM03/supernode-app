import 'package:feedback/src/translation.dart';
import 'package:flutter/material.dart';

class FeedbackWidgetForm extends StatefulWidget {
  const FeedbackWidgetForm(this.translation, this.sendFeedback);

  final FeedbackTranslation translation;
  final void Function(String text) sendFeedback;

  @override
  _FeedbackWidgetFormState createState() => _FeedbackWidgetFormState();
}

class _FeedbackWidgetFormState extends State<FeedbackWidgetForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            widget.translation.feedbackDescriptionText,
            maxLines: 2,
          ),
          TextField(
            maxLines: 2,
            minLines: 2,
            controller: textEditingController,
          ),
          FlatButton(
            key: const Key('submit_feedback_button'),
            child: Text(
              widget.translation.submitButtonText,
            ),
            onPressed: () => widget.sendFeedback(
              textEditingController.text,
            ),
          ),
        ],
      ),
    );
  }
}
