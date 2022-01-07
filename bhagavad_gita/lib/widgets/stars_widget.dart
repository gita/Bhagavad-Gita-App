import 'dart:math';
import 'package:bhagavad_gita/Constant/app_colors.dart';
import 'package:flutter/material.dart';

class StarStripe extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;
  StarStripe(this.onRatingSelected, [this.maximumRating = 5]);
  @override
  _StarStripeState createState() => _StarStripeState();
}

var _rating = 0;

class _StarStripeState extends State<StarStripe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(
            onTap: () => setState(() {
              _rating = i + 1;
              this.widget.onRatingSelected(_rating);
            }),
            child: BlinkingStar(active: i < _rating),
          ),
      ],
    );
  }
}

class BlinkingStar extends StatefulWidget {
  const BlinkingStar({Key? key, required this.active}) : super(key: key);

  final bool active;

  @override
  _BlinkingStarState createState() => _BlinkingStarState();
}

class _BlinkingStarState extends State<BlinkingStar>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BlinkingStar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 48,
              width: 48,
              child: Icon(Icons.star_rounded,
                  color: widget.active ? lightOrangeColor : orangeColor,
                  size: 50),
            ),
            Container(
              alignment: Alignment.center,
              height: 48,
              width: 48,
              child: Icon(Icons.star_rounded,
                  color: widget.active ? orangeColor : lightOrangeColor,
                  size: 48),
            ),
          ],
        ),
        Positioned(
            top: 22,
            left: 18,
            child: AnimatedEye(size: 3, animation: _controller)),
        Positioned(
            top: 22,
            right: 18,
            child: AnimatedEye(size: 3, animation: _controller)),
        Positioned(
          top: _rating <= 3
              ? 28.0
              : _rating == 4
                  ? 25.0
                  : 22.0,
          right: _rating == 0 ? 21.0 : 18.0,
          child: SizedBox(
            width: _rating == 0 ? 5.0 : 11.0,
            height: _rating == 1 || _rating == 5
                ? 10.0
                : _rating == 3
                    ? 1.0
                    : 5.0,
            child: CustomPaint(
              painter: _ArcPainter(),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedEye extends StatelessWidget {
  const AnimatedEye({Key? key, required this.size, required this.animation})
      : super(key: key);

  final double size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // 0..1 -> 1..0..1
        final value = animation.value * 2;
        final scale = value < 1 ? 1 - value : value - 1;
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter();

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    if (_rating == 0) {
      canvas.drawArc(
          rect,
          0.0,
          -pi,
          false,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);
      canvas.drawArc(
          rect,
          0.0,
          pi,
          false,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);
    } else if (_rating <= 2) {
      canvas.drawArc(
          rect,
          0.0,
          -pi,
          false,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);
    } else if (_rating == 3) {
      canvas.drawLine(
          rect.centerLeft,
          rect.centerRight,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);
    } else {
      canvas.drawArc(
          rect,
          0.0,
          pi,
          false,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);
    }
  }
}
