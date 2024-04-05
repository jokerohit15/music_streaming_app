

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_streaming_app/core/app_constants/app_colors.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        CustomPaint(
          size: const Size(500, 30),
          painter: WaveformPainter(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: CustomPaint(
            size: const Size(500, 70),
            painter: WaveformPainter(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor),
          ),
        ),
      ],
    );
  }
}

class WaveformPainter extends CustomPainter {
  final Color color;

  WaveformPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var path = Path();

    // Assuming you want to draw the waveform as shown in the picture
    // This is a simple two-point waveform for example purposes
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4,
        size.height, // Control point
        size.width / 2,
        size.height / 2 // End point
    );
    path.quadraticBezierTo(
        size.width * 3 / 4,
        0, // Control point
        size.width,
        size.height / 2 // End point
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
