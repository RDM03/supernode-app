import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class BottomNavTabViewModel {
  String title;
  String imageUrl;
  String selectImageUrl;
  VoidCallback onTap;

  BottomNavTabViewModel(
      {this.title, this.imageUrl, this.selectImageUrl, this.onTap});
}

class BottomNavTab extends StatefulWidget {
  final List<BottomNavTabViewModel> viewModel;
  final int selectIndex;

  const BottomNavTab({Key key, @required this.viewModel, this.selectIndex = 0})
      : super(key: key);

  @override
  _BottomNavTabState createState() => _BottomNavTabState();
}

class _BottomNavTabState extends State<BottomNavTab>
    with TickerProviderStateMixin {
  TabController _tabController;
  int selectIndex;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: widget.viewModel.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(BottomNavTab oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            offset: Offset(0, 0),
            blurRadius: 3.0,
          )
        ],
      ),
      child: TabBar(
        indicatorColor: Colors.transparent,
        controller: _tabController,
        tabs: widget.viewModel
            .asMap()
            .map((index, tabInfo) =>
                MapEntry(index, _renderTabItem(tabInfo, index)))
            .values
            .toList(),
      ),
    );
  }

  Widget _renderTabItem(BottomNavTabViewModel tabInfo, int index) {
    var screenData = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        tabInfo?.onTap?.call();
      },
      child: Container(
        width: double.infinity,
        height: 82.5 + (screenData?.padding?.bottom ?? 0),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
                widget.selectIndex == index
                    ? tabInfo.selectImageUrl
                    : tabInfo.imageUrl,
                width: 24,
                height: 22,
                fit: BoxFit.contain),
            SizedBox(height: 2),
            Text(
              tabInfo.title ?? "",
              style: widget.selectIndex == index
                  ? FontTheme.of(context).middle.mxc()
                  : FontTheme.of(context).middle.secondary(),
            ),
          ],
        ),
      ),
    );
  }
}
