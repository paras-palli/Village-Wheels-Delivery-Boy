import 'package:flutter/material.dart';

class CustomDashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const CustomDashedLine({
    super.key,
    this.height = 1,
    this.color = Colors.grey, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedLinePainter(color: color, strokeWidth: height),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Color color;

  _DashedLinePainter({
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
    this.strokeWidth = 1.0,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
