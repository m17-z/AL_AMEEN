import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class PacmanAnimation extends StatefulWidget {
  @override
  _PacmanAnimationState createState() => _PacmanAnimationState();
}

class _PacmanAnimationState extends State<PacmanAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _emojiTimer;
  int _currentEmojiIndex = 0;

  // List of emojis
  final List<String> _emojis = ['😊', '😍', '😎', '🤔', '😢'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // Repeat animation indefinitely

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Timer to change the emoji every second
    _emojiTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentEmojiIndex = (_currentEmojiIndex + 1) % _emojis.length;
      });
    });
  }

  @override
  void dispose() {
    _emojiTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: PacmanPainter(
            progress: _animation.value,
            emoji: _emojis[_currentEmojiIndex],
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class PacmanPainter extends CustomPainter {
  final double progress;
  final String emoji;

  PacmanPainter({required this.progress, required this.emoji});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.transparent // No color for emoji
      ..style = PaintingStyle.fill;

    final double pacmanRadius = 20.0;
    final double angle = progress * 2 * pi; // Rotate Pacman around

    final double x = (size.width / 2) + (size.width / 2) * cos(angle) - pacmanRadius;
    final double y = (size.height / 2) + (size.height / 2) * sin(angle) - pacmanRadius;

    // Draw Pacman (circle with a slice removed)
    paint.color = Colors.yellow; // Pacman color
    final Path path = Path()
      ..moveTo(x, y)
      ..arcTo(Rect.fromLTWH(x, y, pacmanRadius * 2, pacmanRadius * 2),
          -pi / 4, // Start angle
          1.5 * pi, // Sweep angle
          false);
    path.close();
    canvas.drawPath(path, paint);

    // Draw emoji
    final textSpan = TextSpan(
      text: emoji,
      style: TextStyle(
        fontSize: pacmanRadius * 1.5, // Scale the emoji size
        color: Colors.black, // Emoji color
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
