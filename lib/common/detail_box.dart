import "package:flutter/material.dart";
import "package:joshuamangi/models/job_stint.dart";

class DetailBox extends StatelessWidget {
  final JobStint content;

  const DetailBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DynamicDetailBox(
        content: content,
      ),
    );
  }
}

class DynamicDetailBox extends StatelessWidget {
  final JobStint content;

  const DynamicDetailBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (content, constraints) {
        return IntrinsicHeight(
          child: SizedBox(
            width: 400, // Fixed width
            child: CustomPaint(
              painter: PaintedDetailBox(),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.content.jobPosition,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      this.content.company,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PaintedDetailBox extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    // Create a rounded rectangle with a triangle on the left side
    double radius = 5.0; // Radius for the rounded corners

    // Top-left corner
    path.moveTo(radius, 0);
    path.arcToPoint(Offset(0, radius),
        radius: Radius.circular(radius), clockwise: false);

    // Left edge until just before the middle
    path.lineTo(0, size.height / 2 - 12);

    // Draw the pointed triangle
    path.lineTo(-10, size.height / 2); // Point of the triangle
    path.lineTo(0, size.height / 2 + 12);

    // Continue the left edge
    path.lineTo(0, size.height - radius);

    // Bottom-left corner
    path.arcToPoint(Offset(radius, size.height),
        radius: Radius.circular(radius), clockwise: false);

    // Bottom edge
    path.lineTo(size.width - radius, size.height);

    // Bottom-right corner
    path.arcToPoint(Offset(size.width, size.height - radius),
        radius: Radius.circular(radius), clockwise: false);

    // Right edge
    path.lineTo(size.width, radius);

    // Top-right corner
    path.arcToPoint(Offset(size.width - radius, 0),
        radius: Radius.circular(radius), clockwise: false);

    // Close the path
    path.lineTo(radius, 0);

    // Fill the shape
    canvas.drawPath(path, paint);

    // Draw the border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
