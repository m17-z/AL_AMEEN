import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Colors2.dart';
import 'Lang/LanguageProvider.dart';

class TextChangerAnimation extends StatefulWidget {
  @override
  _TextChangerAnimationState createState() => _TextChangerAnimationState();
}

class _TextChangerAnimationState extends State<TextChangerAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _textTimer;
  int _currentTextIndex = 0;


  // List of texts
  final List<String> _textsar = ['تمويل ونجاح', 'قروض مرنة', 'الامين للافضل', 'معا نحو التميز',];
  final List<String> _textsen = [
    'Funding and Success',
    'Flexible Loans',
    'The Best Trustee',
    'Together Towards Excellence',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // Repeat animation indefinitely

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Timer to change the text every second
    _textTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % _textsar.length;
      });
    });
  }

  @override
  void dispose() {
    _textTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: PacmanPainter(
            progress: _animation.value,
            // text: _textsar[_currentTextIndex],
            text:
            languageProvider.languageCode == 'en' ? _textsen[_currentTextIndex] :   _textsar[_currentTextIndex],




          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class PacmanPainter extends CustomPainter {
  final double progress;
  final String text;

  PacmanPainter({required this.progress, required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.transparent // No color for emoji
      ..style = PaintingStyle.fill;

    final double pacmanRadius = 50.0;


    final double angle = progress * 2 * pi; // Rotate Pacman around

    final double x = (size.width / 2) + (size.width / 2) * cos(angle) - pacmanRadius;
    final double y = (size.height / 2) + (size.height / 2) * sin(angle) - pacmanRadius;

    // Draw Pacman (circle with a slice removed)
    // paint.color = Colors.yellow; // Pacman color
    paint.color = MyColors.primaryColor; // Pacman color
    final Path path = Path()
      ..moveTo(x, y)
      ..arcTo(Rect.fromLTWH(x, y, pacmanRadius * 2, pacmanRadius * 2),
          -pi / 4, // Start angle
          1.5 * pi, // Sweep angle
          false);
    path.close();
    canvas.drawPath(path, paint);

    // Draw text
    final textSpan = TextSpan(
      text: text,
      style: GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(x + pacmanRadius - textPainter.width / 2, y + pacmanRadius - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
