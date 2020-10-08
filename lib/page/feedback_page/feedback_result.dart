import 'dart:typed_data';

import 'package:feedback/feedback.dart';
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
  final Uint8List image;

  FeedbackResult(this.resultType, this.feedbackType, this.image);
}

class FeedbackResultPage extends StatefulWidget {
  final FeedbackParams params;
  final Uint8List image;
  final DatadashTranslation translation;
  FeedbackResultPage(this.params, this.image, this.translation);

  static const _buttonColor = Color.fromARGB(255, 28, 20, 120);
  static final _screenshotKey = GlobalKey();

  @override
  _FeedbackResultPageState createState() => _FeedbackResultPageState();
}

class _FeedbackResultPageState extends State<FeedbackResultPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<FeedbackType> _showFeedbackDialog(BuildContext context) {
    return showCupertinoModalPopup<FeedbackType>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            widget.translation.translate('feedback'),
            style: kBigFontOfBlue,
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              key: ValueKey('bugButton'),
              child: Text(
                widget.translation.translate('this_is_bug'),
                style: kBigFontOfBlack,
              ),
              onPressed: () => Navigator.of(context).pop(FeedbackType.bug),
            ),
            CupertinoActionSheetAction(
              key: ValueKey('ideaButton'),
              child: Text(
                widget.translation.translate('this_is_idea'),
                style: kBigFontOfBlack,
              ),
              onPressed: () => Navigator.of(context).pop(FeedbackType.idea),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            key: ValueKey('cancelButton'),
            child: Text(
              widget.translation.translate('cancel_normalized'),
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
    final screenshot = await screenshotController.capture(pixelRatio: 2.0);
    if (type == FeedbackResultType.feedback) {
      res = await _showFeedbackDialog(context);
      if (res == null) return;
    }
    Navigator.of(context).pop(FeedbackResult(type, res, screenshot));
  }

  Widget _button(String title, Widget icon, VoidCallback onTap, {Key key}) {
    return GestureDetector(
      key: key,
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
              child: Stack(
                children: [
                  Screenshot(
                    containerKey: FeedbackResultPage._screenshotKey,
                    controller: screenshotController,
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
                          if (widget.params.title.isNotEmpty) ...[
                            SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.params.title,
                                style: kBigFontOfBlack.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20)
                                  .copyWith(bottom: 20),
                              alignment: Alignment.bottomCenter,
                              child: Image.memory(
                                widget.image,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 18),
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
                                widget.translation.translate('feedback'),
                                Icon(
                                  Icons.send,
                                  color: FeedbackResultPage._buttonColor,
                                  size: 15,
                                ),
                                () => _onAction(
                                    context, FeedbackResultType.feedback),
                                key: ValueKey('sendFeedbackButton'),
                              ),
                            ),
                            _divider(),
                            Expanded(
                              child: _button(
                                widget.translation.translate('share'),
                                FaIcon(
                                  FontAwesomeIcons.solidShareSquare,
                                  color: FeedbackResultPage._buttonColor,
                                  size: 14,
                                ),
                                () => _onAction(
                                    context, FeedbackResultType.share),
                                key: ValueKey('shareButton'),
                              ),
                            ),
                            _divider(),
                            Expanded(
                              child: _button(
                                widget.translation
                                    .translate('cancel_normalized'),
                                Icon(
                                  Icons.close,
                                  color: FeedbackResultPage._buttonColor,
                                  size: 18,
                                ),
                                () => _onAction(
                                    context, FeedbackResultType.cancel),
                                key: ValueKey('cancelFeedbackButton'),
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
          ),
        ),
      ),
    );
  }
}
