import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class TabIndicator extends Decoration {
  final Color color;

  TabIndicator(this.color);

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _CustomBoxPainter(color);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final Color color;

  _CustomBoxPainter(this.color);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Size tabSize = Size(configuration.size.width, configuration.size.height);
    final Rect rect = offset & tabSize;

    RRect rectWithRadius = RRect.fromRectAndRadius(rect, Radius.circular(10.0));
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    canvas.drawRRect(rectWithRadius, paint);
  }
}
