import 'package:flutter/material.dart';

class StaggeredScaleAnimatedWidget extends AnimatedWidget {
  final Widget child;
  final Animation<double> scaleAnimation;
  StaggeredScaleAnimatedWidget(
      {Key? key,
      required Animation<double> animation,
      required int index,
      required this.child})
      : scaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.1 * index,
              0.5 + 0.1 * index,
              curve: Curves.easeInOutCubic
            ),
          ),
        ),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    //final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: scaleAnimation.value,
      alignment: Alignment.center,
      child: child,
    );
  }
}
