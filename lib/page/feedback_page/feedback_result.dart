import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/daos/jira_dao.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';
import 'package:supernodeapp/theme/font.dart';

enum FeedbackResultType { cancel, feedback, share }

class FeedbackResult {
  final FeedbackResultType resultType;
  final FeedbackType feedbackType;

  FeedbackResult(this.resultType, this.feedbackType);
}

class FeedbackResultPage extends StatelessWidget {
  final FeedbackParams params;
  final Uint8List image;
  final DatadashTranslation translation;
  FeedbackResultPage(this.params, this.image, this.translation);

  static const _buttonColor = Color.fromARGB(255, 28, 20, 120);

  Future<FeedbackType> _showFeedbackDialog(BuildContext context) {
    return showCupertinoModalPopup<FeedbackType>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            translation.translate('feedback'),
            style: kBigFontOfBlue,
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                translation.translate('this_is_bug'),
                style: kBigFontOfBlack,
              ),
              onPressed: () => Navigator.of(context).pop(FeedbackType.bug),
            ),
            CupertinoActionSheetAction(
              child: Text(
                translation.translate('this_is_idea'),
                style: kBigFontOfBlack,
              ),
              onPressed: () => Navigator.of(context).pop(FeedbackType.idea),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text(
              translation.translate('cancel_normalized'),
              style: kBigFontOfBlack,
            ),
            onPressed: () => Navigator.of(context).pop<FeedbackType>(),
          ),
        );
      },
    );
  }

  void _onAction(BuildContext context, FeedbackResultType type) async {
    FeedbackType res;
    if (type == FeedbackResultType.feedback) {
      res = await _showFeedbackDialog(context);
      if (res == null) return;
    }
    Navigator.of(context).pop(FeedbackResult(type, res));
  }

  Widget _button(String title, Widget icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10),
            Flexible(
              child: Text(
                title,
                style: kSmallFontOfDarkBlue,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 2,
      margin: EdgeInsets.symmetric(vertical: 4),
      height: double.infinity,
      color: Color.fromARGB(255, 235, 239, 242),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 32,
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 7),
                  Image.asset(
                    'assets/images/splash/logo.png',
                    height: 35,
                  ),
                  Center(
                    child: Text('mxc.org'),
                  ),
                  if (params.title.isNotEmpty) ...[
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        params.title,
                        style: kBigFontOfBlack.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(bottom: 20),
                          alignment: Alignment.bottomCenter,
                          child: Image.memory(
                            image,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 3,
                            child: Container(
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _button(
                                      translation.translate('feedback'),
                                      Icon(
                                        Icons.send,
                                        color: _buttonColor,
                                        size: 15,
                                      ),
                                      () => _onAction(
                                          context, FeedbackResultType.feedback),
                                    ),
                                  ),
                                  _divider(),
                                  Expanded(
                                    child: _button(
                                      translation.translate('share'),
                                      FaIcon(
                                        FontAwesomeIcons.solidShareSquare,
                                        color: _buttonColor,
                                        size: 14,
                                      ),
                                      () => _onAction(
                                          context, FeedbackResultType.share),
                                    ),
                                  ),
                                  _divider(),
                                  Expanded(
                                    child: _button(
                                      translation
                                          .translate('cancel_normalized'),
                                      Icon(
                                        Icons.close,
                                        color: _buttonColor,
                                        size: 18,
                                      ),
                                      () => _onAction(
                                          context, FeedbackResultType.cancel),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
