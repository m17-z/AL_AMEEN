import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class EmojeChangerAnimation extends StatefulWidget {
  @override
  _EmojeChangerAnimationState createState() => _EmojeChangerAnimationState();
}

class _EmojeChangerAnimationState extends State<EmojeChangerAnimation> with SingleTickerProviderStateMixin {
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
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation with reverse

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
          painter: MovingCirclePainter(
            progress: _animation.value,
            emoji: _emojis[_currentEmojiIndex],
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class MovingCirclePainter extends CustomPainter {
  final double progress;
  final String emoji;

  MovingCirclePainter({required this.progress, required this.emoji});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.transparent // No color for emoji
      ..style = PaintingStyle.fill;

    final double circleRadius = 20.0;
    final double x = progress * size.width;
    final double y = size.height / 2;

    // Draw circle
    paint.color = Colors.blue; // or any other color you want
    canvas.drawCircle(Offset(x, y), circleRadius, paint);

    // Draw emoji
    final textSpan = TextSpan(
      text: emoji,
      style: TextStyle(
        fontSize: circleRadius * 2, // Scale the emoji size
        color: Colors.white, // Emoji color
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
