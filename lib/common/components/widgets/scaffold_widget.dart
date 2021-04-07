import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/utils.dart';

import 'prefer_height_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    Key key,
    this.appBar,
    this.body,
    this.footer,
    this.backgroundColor,
    this.useScrollViewContainer = true,
    this.padding,
    this.scrollController,
    this.useSafeArea = true,
  })  : assert(body != null),
        super(key: key);

  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget footer;
  final EdgeInsets padding;
  final Color backgroundColor;
  final bool useScrollViewContainer;
  final ScrollController scrollController;
  final bool useSafeArea;

  EdgeInsets get _padding => this.padding ?? EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? PreferHeightWidget(height: 0),
      body: _buildBody(context, (context) => body),
      backgroundColor: this.backgroundColor,
      bottomNavigationBar: _buildFooter(context, this.footer),
    );
  }

  Widget _buildBody(BuildContext context, WidgetBuilder bodyBuilder) {
    final scrollController = this.scrollController ?? ScrollController();

    Widget _wrapWithScrollViewIfNeed(Widget child) {
      if (!this.useScrollViewContainer) return child;
      return SingleChildScrollView(
        padding: _padding,
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        child: child,
      );
    }

    Widget _buildContent() {
      return Container(
        padding: useScrollViewContainer ? EdgeInsets.zero : _padding,
        child: _wrapWithScrollViewIfNeed(bodyBuilder(context)),
      );
    }

    return this.useSafeArea
        ? SafeArea(child: _buildContent())
        : _buildContent();
  }

  Widget _buildFooter(BuildContext context, Widget footer) {
    if (footer == null) return SizedBox();
    return Padding(
      padding: _padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          footer,
          UiUtils.buildSafeBottom(context),
        ],
      ),
    );
  }
}
