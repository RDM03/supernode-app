import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class SliverFooter extends SingleChildRenderObjectWidget {
  final double preferredSize;

  /// Creates a sliver that fills the remaining space in the viewport.
  const SliverFooter({
    Key key,
    Widget child,
    this.preferredSize,
  }) : super(key: key, child: child);

  @override
  RenderSliverFooter createRenderObject(BuildContext context) =>
      RenderSliverFooter(footer: this);
}

class RenderSliverFooter extends RenderSliverSingleBoxAdapter {
  final SliverFooter footer;

  /// Creates a [RenderSliver] that wraps a [RenderBox] which is sized to fit
  /// the remaining space in the viewport.
  RenderSliverFooter({
    RenderBox child,
    this.footer,
  }) : super(child: child);

  @override
  void performLayout() {
    final extent =
        constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    var childGrowthSize = .0; // added
    if (child != null) {
      // changed maxExtent from 'extent' to double.infinity
      child.layout(
          constraints.asBoxConstraints(
              minExtent: extent, maxExtent: double.infinity),
          parentUsesSize: true);
      childGrowthSize = constraints.axis == Axis.vertical
          ? child.size.height
          : child.size.width; // added
    }
    final paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: extent);
    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = new SliverGeometry(
      // used to be this : scrollExtent: constraints.viewportMainAxisExtent,
      scrollExtent: math.min(footer.preferredSize, childGrowthSize),
      paintExtent: paintedChildSize,
      maxPaintExtent: paintedChildSize,
      hasVisualOverflow: extent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    if (child != null) {
      setChildParentData(child, constraints, geometry);
    }
  }
}
