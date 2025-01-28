import 'package:flutter/material.dart';

class RoundedRectangleTabIndicator extends Decoration {

  RoundedRectangleTabIndicator(
      {required Color color, required double weight, required double width})
      : _painter = _RRectanglePainterColor(color, weight, width);
  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RRectanglePainterColor extends BoxPainter {

  _RRectanglePainterColor(Color color, this.weight, this.width)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;
  final Paint _paint;
  final double weight;
  final double width;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final customOffset = offset + Offset(0, cfg.size!.height - weight);

    //Custom Rectangle
    var myRect = customOffset & Size(width, weight);

    // Custom Rounded Rectangle
    var myRRect = RRect.fromRectXY(myRect, weight, weight);

    canvas.drawRRect(myRRect, _paint);
  }
}
