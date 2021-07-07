import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/jira_repository.dart';
import 'package:supernodeapp/common/repositories/shared/dao/jira_dao.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';
import 'package:supernodeapp/page/feedback_page/feedback_result.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class DatadashFeedbackWidgetForm extends StatefulWidget {
  const DatadashFeedbackWidgetForm(this.translation, this.sendFeedback);
  final DatadashTranslation translation;
  final void Function(String text, FeedbackParams params) sendFeedback;

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
                  SizedBox(height: 10),
                  PrimaryButton(
                    key: const Key('submit_feedback_button'),
                    buttonTitle: widget.translation.submitButtonText,
                    onTap: () => widget.sendFeedback(
                      textEditingController.text,
                      FeedbackParams(
                        critical: false,
                        title: textEditingController.text,
                        type: null,
                        description: 'Issue from datadash feedback system',
                      ),
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
                  Navigator.of(context).pop();
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

  String translate(String key) {
    final ctx = context();
    if (ctx == null) return 'loading...';
    return FlutterI18n.translate(context(), key);
  }

  @override
  String get draw => translate('draw');

  @override
  String get feedbackDescriptionText => translate('whats_up');

  @override
  String get navigate => '???';

  @override
  String get submitButtonText => translate('done');
}

class _DatadashFeedbackInherited extends InheritedWidget {
  final DatadashFeedbackState data;

  _DatadashFeedbackInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class DatadashFeedback extends StatefulWidget {
  final Widget child;
  DatadashFeedback({this.child});

  static DatadashFeedbackState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DatadashFeedbackInherited>()
        .data;
  }

  @override
  DatadashFeedbackState createState() => DatadashFeedbackState();
}

class DatadashFeedbackState extends State<DatadashFeedback> {
  bool _showScreenshot;
  bool get showScreenshot => _showScreenshot;

  Future<void> setShowScreenshot(bool value) async {
    setState(() => _showScreenshot = value);
    await context.read<StorageRepository>().setShowFeedback(value);
  }

  @override
  void initState() {
    super.initState();
    _showScreenshot = context.read<StorageRepository>().showFeedback();
  }

  @override
  Widget build(BuildContext context) {
    final tr = DatadashTranslation(() => navigatorKey.currentContext);
    return _DatadashFeedbackInherited(
      data: this,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              widget.child,
              if (_showScreenshot)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: GestureDetector(
                      key: ValueKey('feedbackButton'),
                      onTap: () async {
                        //however, focusing to hide loading.
                        context.read<AppCubit>().setLoading(false);

                        setState(() => _showScreenshot = false);
                        // wait while camera icon disapper
                        await Future.delayed(Duration(milliseconds: 300));
                        try {
                          await onFeedback(navigatorKey.currentContext);
                        } finally {
                          setState(() => _showScreenshot = true);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: blackColor70,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.all(4).copyWith(right: 4, left: 6),
                          child: Icon(
                            Icons.camera_alt,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> onFeedback(BuildContext context) async {
  final tr = DatadashTranslation(() => navigatorKey.currentContext);
  final res = await BetterFeedback.show<FeedbackParams>(
    context,
    translation: tr,
    formBuilder: (s) => DatadashFeedbackWidgetForm(tr, s),
  );
  if (res == null) return;

  await submitJiraFeedback(context, res.params, res.image);
}

Future<bool> submitJiraFeedback(
  BuildContext ctx,
  FeedbackParams params,
  Uint8List image,
) async {
  final res = await Navigator.of(ctx).push(PageRouteBuilder(
    pageBuilder: (_, __, ___) => FeedbackResultPage(
        params, image, DatadashTranslation(() => navigatorKey.currentContext)),
    opaque: false,
  )) as FeedbackResult;
  if (res == null) return false;
  image = res.image;
  if (res.resultType == FeedbackResultType.feedback) {
    params = params.copyWith(type: res.feedbackType);
    final dao = JiraRepository();
    final issueId = await dao.createIssue(params);
    await dao.addImage(issueId, image);
    tip('Ticket created', success: true);
  } else if (res.resultType == FeedbackResultType.share) {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/share_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(image);
    Share.shareFiles([file.path], text: params.title);
  }
  return true;
}
