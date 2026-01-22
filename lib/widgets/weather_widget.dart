import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherWidget extends StatelessWidget {
  final String temperature;
  final String windSpeed;
  final String windDirection;
  final String irradiation;
  final String weatherIconPath; // Changed to use image path

  const WeatherWidget({
    super.key,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.irradiation,
    required this.weatherIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9966FF), Color(0xFF6633CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Temperature section with thermometer
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      temperature,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Module\nTemperature',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Thermometer
                SizedBox(
                  width: 35,
                  height: 90,
                  child: CustomPaint(
                    painter: ThermometerPainter(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Weather details section
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$windSpeed / $windDirection',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Wind Speed & Direction',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          irradiation,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Effective Irradiation',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Weather icon
                  Image.asset(
                    weatherIconPath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final fillPaint = Paint()
      ..color = const Color(0xFFFF6B6B)
      ..style = PaintingStyle.fill;

    final whiteFillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw temperature scale marks
    final scalePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;

    // Scale marks (45°C, 30°C, 15°C, 0°C)
    final scalePositions = [0.15, 0.35, 0.55, 0.75];
    for (var pos in scalePositions) {
      canvas.drawLine(
        Offset(size.width / 2 + 8, size.height * pos),
        Offset(size.width / 2 + 13, size.height * pos),
        scalePaint,
      );
    }

    // Draw thermometer tube (white outline)
    final tubeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width / 2 - 6, 8, 12, size.height - 28),
      const Radius.circular(6),
    );
    canvas.drawRRect(tubeRect, paint);

    // White background for tube
    final tubeBackgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width / 2 - 4.5, 10, 9, size.height - 32),
      const Radius.circular(4.5),
    );
    canvas.drawRRect(tubeBackgroundRect, whiteFillPaint);

    // Draw thermometer bulb (bottom circle)
    canvas.drawCircle(
      Offset(size.width / 2, size.height - 10),
      10,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height - 10),
      8,
      whiteFillPaint,
    );

    // Draw red fill level (mercury)
    final fillHeight = size.height * 0.5; // 50% fill for 17°C
    final fillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width / 2 - 3.5,
        size.height - 30 - fillHeight,
        7,
        fillHeight,
      ),
      const Radius.circular(3.5),
    );
    canvas.drawRRect(fillRect, fillPaint);

    // Red fill in bulb
    canvas.drawCircle(
      Offset(size.width / 2, size.height - 10),
      6.5,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
