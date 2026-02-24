import 'dart:math';

import 'package:flutter/material.dart';

class RatingRow extends StatefulWidget {
  final int maxRating;
  final double currentRating;
  final Color starColor;
  final double starSize;
  final EdgeInsets itemsPadding;

  const RatingRow({
    super.key,
    this.maxRating = 5,
    required this.currentRating,
    this.starColor = Colors.amber,
    this.starSize = 32.0,
    this.itemsPadding = const EdgeInsets.symmetric(horizontal: 4),
  });

  @override
  State<StatefulWidget> createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow>{
  @override
  Widget build(BuildContext context) {
    final floatingIndex = (widget.currentRating * 10).toInt() / 10;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return Padding(
          padding: widget.itemsPadding,
          child: SizedBox(
            width: widget.starSize,
            height: widget.starSize,
            child: CustomPaint(
              painter: _StarPainter(
                fillPercentage: _getFillPercentage(index, floatingIndex),
                color: widget.starColor,
              ),
            ),
          ),
        );
      }),
    );
  }

  double _getFillPercentage(int index, double floatingIndex) {
    if (widget.currentRating > index && index != floatingIndex.floor()) {
      return 1.0;
    } else if (index == floatingIndex.floor()) {
      return widget.currentRating - floatingIndex.floor();
    }
    return 0.0;
  }
}

class _StarPainter extends CustomPainter {
  final double fillPercentage;
  final Color color;

  _StarPainter({
    required this.fillPercentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createStarPath(size);
    
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;
    
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        stops: [fillPercentage, fillPercentage],
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, fillPaint);
  }

  Path _createStarPath(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    const points = 5;
    final outerRadius = size.width / 2;
    final innerRadius = size.width / 4;
    const startAngle = -pi / 2;

    for (int i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = startAngle + (i * pi / points);
      
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
           oldDelegate.color != color;
  }

}