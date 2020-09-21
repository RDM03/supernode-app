import 'package:feedback/src/feedback_controller.dart';
import 'package:feedback/src/feedback_functions.dart';
import 'package:feedback/src/feedback_widget.dart';
import 'package:feedback/src/translation.dart';
import 'package:flutter/material.dart';

/// This widget should be at the top of your widget tree.
class BetterFeedback<T> extends StatefulWidget {
  const BetterFeedback({
    Key key,
    @required this.child,
    @required this.onFeedback,
    this.backgroundColor,
    this.drawColors,
    this.translation,
    this.formBuilder,
  })  : assert(child != null),
        assert(onFeedback != null),
        super(key: key);

  /// Gets called when the user submits his feedback.
  final OnFeedbackCallback<T> onFeedback;

  /// The application to wrap, typically a [MaterialApp].
  final Widget child;

  /// The background of the feedback view.
  final Color backgroundColor;

  /// Colors which can be used to draw on [child].
  final List<Color> drawColors;

  /// Optional translation for the feedback view, defaults to english.
  final FeedbackTranslation translation;

  /// Optional feedback form builder
  final Widget Function(Future<void> Function(String text, [T params]) submit)
      formBuilder;

  /// Call `BetterFeedback.of(context)` to get an instance of
  /// [FeedbackData] on which you can call `.show()` or `.hide()`
  /// to enable or disable the feedback view.
  static FeedbackData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FeedbackData>();

  @override
  _BetterFeedbackState createState() => _BetterFeedbackState<T>();
}

class _BetterFeedbackState<T> extends State<BetterFeedback<T>> {
  FeedbackController controller = FeedbackController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onUpdateOfController);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(onUpdateOfController);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeedbackData(
        controller: controller,
        child: FeedbackWidget<T>(
          child: widget.child,
          screenshot: controller.screenshot,
          isFeedbackVisible: controller.isVisible,
          onFeedbackSubmitted: widget.onFeedback,
          backgroundColor: widget.backgroundColor,
          drawColors: widget.drawColors,
          formBuilder: widget.formBuilder,
          translation: widget.translation ?? EnTranslation(),
        ),
      ),
    );
  }

  void onUpdateOfController() {
    setState(() {});
  }
}

class FeedbackData extends InheritedWidget {
  const FeedbackData({
    Key key,
    @required Widget child,
    @required this.controller,
  })  : assert(child != null),
        assert(controller != null),
        super(key: key, child: child);

  final FeedbackController controller;

  @override
  bool updateShouldNotify(FeedbackData oldWidget) {
    return oldWidget.controller != controller;
  }

  /// Shows the feedback view
  Future<void> show() => controller.show();

  /// Hides the feedback view
  void hide() => controller.hide();

  bool get isVisible => controller.isVisible;
}
