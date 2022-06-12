import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;
  const TaskCompletionRing({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          progress: progress,
          taskNotCompletedColor: themeData.taskRing,
          taskCompletedColor: themeData.accent,
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  RingPainter({
    required this.progress,
    required this.taskNotCompletedColor,
    required this.taskCompletedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
