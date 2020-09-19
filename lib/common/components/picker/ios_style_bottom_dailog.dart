import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class IosButtonStyle {
  String title;
  TextStyle style;

  IosButtonStyle({String title, TextStyle style = kBigFontOfBlack}) {
    this.title = title;
    this.style = style;
  }
}

typedef OnItemClickListener = void Function(int index);

class IosStyleBottomDialog extends StatelessWidget {
  final int blueActionIndex;
  final List<IosButtonStyle> list;
  final OnItemClickListener onItemClickListener;
  final BuildContext context;

  const IosStyleBottomDialog({
    Key key,
    @required this.list,
    this.onItemClickListener,
    this.blueActionIndex = -1,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: <Widget>[
                _buildContentList(context),
                _buildCancelItem(context),
              ],
            ),
          ),
        ),
      ],
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
        listContent.add(_buildItem(
          context,
          button: list[i],
        ));
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
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(button?.title ?? '', style: kBigFontOfBlue),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {IosButtonStyle button, int index}) {
    return InkWell(
      onTap: () {
        onItemClickListener(index);
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(button?.title ?? '', style: button.style),
      ),
    );
  }

  Widget _buildCancelItem(context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(FlutterI18n.translate(context, 'device_cancel'),
            style: kBigFontOfBlack),
      ),
    );
  }
}
