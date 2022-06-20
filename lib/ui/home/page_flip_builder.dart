import 'dart:math';

import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  const PageFlipBuilder({
    Key? key,
    required this.frontBuilder,
    required this.backBuilder,
  }) : super(key: key);

  @override
  State<PageFlipBuilder> createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 700));

  bool _showFrontSide = true;

  @override
  void initState() {
    _controller.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() => _showFrontSide = !_showFrontSide);
    }
  }

  void flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPageFlipBuilder(
      animation: _controller,
      showFrontSide: _showFrontSide,
      frontBuilder: widget.frontBuilder,
      backBuilder: widget.backBuilder,
    );
  }
}

class AnimatedPageFlipBuilder extends AnimatedWidget {
  final bool showFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  const AnimatedPageFlipBuilder({
    Key? key,
    required Animation<double> animation,
    required this.showFrontSide,
    required this.frontBuilder,
    required this.backBuilder,
  }) : super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    // animation values are between [0, 1] => rotation [0, pi]
    // show the front side for animation values between 0.0, and 0.5
    // show the back side for animation values between 0.5, and 0.

    // this bool tells use if we're in the first or second half of the animation
    final isAnimationFirstHalf = animation.value < 0.5;

    //decide which page we need to show
    final child =
        isAnimationFirstHalf ? frontBuilder(context) : backBuilder(context);

    // we need to map value between [0, 1] to values between [0, pi]
    final rotationValue = animation.value * pi;

    // calculate the correct rotation angle depending on which side we need to show
    final rotationAngle =
        animation.value > 0.5 ? pi - rotationValue : rotationValue;

    //calculate the tilt value
    var tilt = (animation.value - 0.5).abs() - 0.5;

    //make this a small value (positive or negative)

    tilt *= isAnimationFirstHalf ? -0.003 : 0.003;

    return Transform(
      transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tilt),
      alignment: Alignment.center,
      child: child,
    );
  }
}
