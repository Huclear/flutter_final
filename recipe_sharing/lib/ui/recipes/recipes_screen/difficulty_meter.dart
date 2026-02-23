import 'dart:math';

import 'package:flutter/material.dart';
import '../../../domain/models/recipes/recipe_difficulty.dart';

class DifficultyMeter extends StatefulWidget {
  final RecipeDifficulty difficulty;

  const DifficultyMeter({super.key, required this.difficulty});

  @override
  State<StatefulWidget> createState() => _DifficultyMeterState();
}

class _DifficultyMeterState extends State<DifficultyMeter> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DifficultyMeterPainter(widget.difficulty),
      child: Container(),
    );
  }
}

class _DifficultyMeterPainter extends CustomPainter {
  final RecipeDifficulty difficulty;

  _DifficultyMeterPainter(this.difficulty);

  @override
  void paint(Canvas canvas, Size size) {
    final arcDegrees = 275;
    final startArcAngle =
        -225.0; // 135 degrees converted to radians (135 - 360)
    final startStepAngle = -45.0;
    final numberOfMarkers = RecipeDifficulty.values.length;
    final degreesMarkerStep = arcDegrees / numberOfMarkers;
    final progress = RecipeDifficulty.values.indexOf(difficulty) + 1;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: size.width / 2);

    final (progressColor, progressBackgroundColor) = switch (difficulty) {
      RecipeDifficulty.beginner => (
        const Color(0xFF388E3C),
        const Color(0xFFC8E6C9),
      ),
      RecipeDifficulty.common => (
        const Color(0xFFCCC916),
        const Color(0xFFE5E6C8),
      ),
      RecipeDifficulty.adept => (
        const Color(0xFFE3700B),
        const Color(0xFFE5C5A3),
      ),
      RecipeDifficulty.masterpiece => (
        const Color(0xFFFF0000),
        const Color(0xFFE6C8C8),
      ),
    };

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 5
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    paint.color = progressBackgroundColor;
    canvas.drawArc(
      rect,
      radians(startArcAngle),
      radians(arcDegrees.toDouble()),
      false,
      paint,
    );

    // Draw progress arc
    paint.color = progressColor;
    canvas.drawArc(
      rect,
      radians(startArcAngle),
      radians(degreesMarkerStep * progress),
      false,
      paint,
    );

    // Draw center circles
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 6, paint..color = progressColor);
    canvas.drawCircle(center, size.width / 9, paint..color = Colors.white);
    canvas.drawCircle(center, size.width / 12, paint..color = Colors.black);

    // Draw pointer
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(radians(startStepAngle + degreesMarkerStep * progress));

    final pointerPath = Path()
      ..moveTo(0, -15)
      ..lineTo(0, 15)
      ..lineTo(-size.width * 0.4, 0)
      ..lineTo(-size.width * 0.4, -10)
      ..close();

    paint.color = Colors.black;
    canvas.drawPath(pointerPath, paint);

    canvas.restore();
  }

  double radians(double degrees) => degrees * (pi / 180);

  @override
  bool shouldRepaint(covariant _DifficultyMeterPainter oldDelegate) {
    return oldDelegate.difficulty != difficulty;
  }
}
