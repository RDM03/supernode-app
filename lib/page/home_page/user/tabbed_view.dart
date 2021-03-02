import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/theme/colors.dart';

class TabbedView extends StatefulWidget {
  final List<Widget> tabs;
  final List<Color> tabsColors;

  final double contentHeight;

  const TabbedView({
    Key key,
    this.tabs,
    this.tabsColors,
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
      child: Column(
        children: [
          SizedBox(
            height: widget.contentHeight,
            child: TabBarView(
              controller: controller,
              children: widget.tabs,
            ),
          ),
          SizedBox(height: 5),
          (controller.length > 1)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.tabsColors.length; i++) ...[
                tabIcon(widget.tabsColors[i], i),
                if (i != widget.tabsColors.length - 1) SizedBox(width: 4)
              ],
            ],
          )
              : SizedBox(),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
