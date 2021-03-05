import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/theme/colors.dart';

class ColorCodedWidget {
  final Widget widget;
  final Color color;

  const ColorCodedWidget(this.widget, this.color);
}

class TabbedView extends StatefulWidget {
  final List<ColorCodedWidget> tabs;
  final IconButton menu;

  final double contentHeight;

  const TabbedView({
    Key key,
    this.tabs,
    this.menu,
    this.contentHeight = 150,
  }) : super(key: key);

  @override
  _TabbedViewState createState() => _TabbedViewState();
}

class _TabbedViewState extends State<TabbedView> with TickerProviderStateMixin {
  TabController controller;
  int selectedTab = 0;

  @override
  void initState() {
    controller = TabController(length: widget.tabs.length, vsync: this);
    controller.addListener(controllerListener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabbedView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      switchController(widget.tabs.length);
    }
  }

  void switchController(int pagesCount) {
    final oldController = controller;
    controller = TabController(length: pagesCount, vsync: this);
    controller.addListener(controllerListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oldController.dispose();
    });
    if (selectedTab == controller.length && selectedTab > 0)
      setState(() {
        selectedTab = selectedTab - 1;
      });
  }

  void controllerListener() {
    if (selectedTab != controller.index && mounted) {
      setState(() {
        selectedTab = controller.index;
      });
    }
  }

  Widget tabIcon(Color color, int index) {
    return GestureDetector(
      onTap: () => controller.animateTo(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 15,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          width: selectedTab == index ? 24 : 22,
          height: 4,
          decoration: BoxDecoration(
            color: selectedTab == index ? color : unselectedColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PanelFrame(
        child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: widget.contentHeight,
                    child: TabBarView(
                      controller: controller,
                      children: widget.tabs.map((e) => e.widget).toList(),
                    ),
                  ),
                  SizedBox(height: 5),
                  (controller.length > 1)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < widget.tabs.length; i++) ...[
                        tabIcon(widget.tabs[i].color, i),
                        if (i != widget.tabs.length - 1) SizedBox(width: 4)
                      ],
                    ],
                  )
                      : SizedBox(),
                  SizedBox(height: 5),
                ],
              ),
              (widget.menu != null) ? widget.menu : SizedBox(),
            ])
    );
  }
}
