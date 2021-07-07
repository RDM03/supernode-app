import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

abstract class _IosStyleBottomDialogBase extends StatelessWidget {
  _IosStyleBottomDialogBase({
    Key key,
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);

  final EdgeInsets margin;

  @override
  Widget build(BuildContext _) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: margin.bottom,
          left: margin.left,
          right: margin.right,
          child: GestureDetector(
            onTap: () {},
            child: buildDialog(),
          ),
        ),
      ],
    );
  }

  Widget buildDialog();
}

class IosButtonStyle {
  String title;
  TextStyle style;

  IosButtonStyle({String title, TextStyle style = kBigFontOfBlack}) {
    this.title = title;
    this.style = style;
  }
}

typedef OnItemClickListener = void Function(int index);

///
/// iOS style Bottom Dialog with list of buttons IosButtonStyle
/// and a separate Cancel button by default
///
class IosStyleBottomDialog extends _IosStyleBottomDialogBase {
  final int blueActionIndex;
  final OnItemClickListener onItemClickListener;
  final List<IosButtonStyle> list;

  IosStyleBottomDialog({
    Key key,
    @required this.list,
    this.onItemClickListener,
    this.blueActionIndex = -1,
  }) : super(key: key);

  @override
  Widget buildDialog() {
    return Builder(
      builder: (context) => Column(
        children: <Widget>[
          _buildContentList(context),
          _buildCancelItem(context),
        ],
      ),
    );
  }

  Widget _buildContentList(BuildContext context) {
    List<Widget> listContent = [];

    if (blueActionIndex > -1 && blueActionIndex < list.length) {
      if (list.length == 1) {
        listContent
            .add(_buildSelectedItem(context, button: list[blueActionIndex]));
      } else {
        listContent
            .add(_buildSelectedItem(context, button: list[blueActionIndex]));
        listContent.add(Divider(color: borderColor, height: 1));
        int i = 0;
        for (; i < list.length - 1; i++) {
          if (blueActionIndex != i) {
            listContent.add(_buildItem(context, button: list[i], index: i));
            listContent.add(Divider(color: borderColor, height: 1));
          }
        }
        listContent.add(_buildItem(context, button: list[i], index: i));
      }
    } else {
      if (list.length == 1) {
        listContent.add(_buildItem(context, button: list[0], index: 0));
      } else {
        int i = 0;
        for (; i < list.length - 1; i++) {
          if (blueActionIndex != i) {
            listContent.add(_buildItem(context, button: list[i], index: i));
            listContent.add(Divider(color: borderColor, height: 1));
          }
        }
        listContent.add(_buildItem(context, button: list[i], index: i));
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ]),
      child: Column(
        children: listContent,
      ),
    );
  }

  Widget _buildSelectedItem(context, {IosButtonStyle button}) {
    return Builder(
      builder: (ctx) => InkWell(
        onTap: () => Navigator.pop(ctx),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(25),
          child: Text(
            button?.title ?? '',
            style: kBigFontOfBlue,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {IosButtonStyle button, int index}) {
    return Builder(
      builder: (ctx) => InkWell(
        onTap: () {
          onItemClickListener(index);
          Navigator.pop(ctx);
        },
        child: Container(
          key: Key("bottom_dialog_item$index"),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
          child: Text(
            button?.title ?? '',
            style: button.style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelItem(context) {
    return Builder(
      builder: (ctx) => InkWell(
        onTap: () {
          Navigator.pop(ctx);
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 43),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: shodowColor,
                  offset: Offset(0, 2),
                  blurRadius: 7,
                ),
              ]),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
          child: Text(
            FlutterI18n.translate(context, 'device_cancel'),
            style: kBigFontOfBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

///
/// iOS style Bottom Dialog with UI defined by param child
///
class IosStyleBottomDialog2 extends _IosStyleBottomDialogBase {
  final WidgetBuilder builder;

  final EdgeInsets padding;
  final bool closeOnTap;

  IosStyleBottomDialog2({
    Key key,
    @required this.builder,
    this.padding =
        const EdgeInsets.only(left: 22, right: 22, top: 28, bottom: 60),
    this.closeOnTap = true,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key, margin: margin);

  @override
  Widget buildDialog() {
    return IosStyleBottomDialog2Content(
      padding: padding,
      child: Builder(builder: builder),
      closeOnTap: closeOnTap,
    );
  }
}

class IosStyleBottomDialog2Content extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool closeOnTap;

  IosStyleBottomDialog2Content({
    Key key,
    this.child,
    this.padding,
    this.closeOnTap,
  }) : super(key: key);

  @override
  _IosStyleBottomDialog2ContentState createState() =>
      _IosStyleBottomDialog2ContentState();
}

class _IosStyleBottomDialog2ContentState
    extends State<IosStyleBottomDialog2Content> {
  bool isClosing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.closeOnTap
          ? () {
              if (!isClosing) {
                isClosing = true;
                Navigator.pop(context);
              }
            }
          : null,
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0.0) {
          //swipe down
          Navigator.pop(context);
        }
      },
      child: Container(
        key: Key("infoDialog"),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shodowColor,
              offset: Offset(0, 2),
              blurRadius: 7,
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}

void showInfoDialog(BuildContext context, Widget child) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return AnimatedBuilder(
        animation: anim1,
        builder: (ctx, child) => Transform.translate(
          offset: Offset(0, 200 - anim1.value * 200),
          child: child,
        ),
        child: FullScreenDialog(child: child),
      );
    },
    barrierDismissible: true,
    barrierColor: blackColor40,
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 200),
  );
}
