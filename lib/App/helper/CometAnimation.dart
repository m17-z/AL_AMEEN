// import 'package:flutter/material.dart';
//
// class MovingCircleAnimation extends StatefulWidget {
//   @override
//   _MovingCircleAnimationState createState() => _MovingCircleAnimationState();
// }
//
// class _MovingCircleAnimationState extends State<MovingCircleAnimation> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true); // Repeat animation with reverse
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: MovingCirclePainter(progress: _animation.value),
//           size: MediaQuery.of(context).size,
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
// class MovingCirclePainter extends CustomPainter {
//   final double progress;
//
//   MovingCirclePainter({required this.progress});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;
//
//     final double circleRadius = 20.0;
//     final double x = progress * size.width;
//     final double y = size.height / 2;
//
//     canvas.drawCircle(Offset(x, y), circleRadius, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class MovingCircleAnimation extends StatefulWidget {
  @override
  _MovingCircleAnimationState createState() => _MovingCircleAnimationState();
}

class _MovingCircleAnimationState extends State<MovingCircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _colorTimer;
  Color _circleColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation with reverse

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Timer to change the color every second
    _colorTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _circleColor = _generateRandomColor();
      });
    });
  }

  @override
  void dispose() {
    _colorTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color _generateRandomColor() {
    // Generate a random color
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: MovingCirclePainter(
            progress: _animation.value,
            color: _circleColor,
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class MovingCirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  MovingCirclePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double circleRadius = 20.0;
    final double x = progress * size.width;
    final double y = size.height / 2;

    canvas.drawCircle(Offset(x, y), circleRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
