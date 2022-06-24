import 'package:flutter/material.dart';

class StaggeredScaleAnimatedWidget extends AnimatedWidget {
  final Widget child;
  const StaggeredScaleAnimatedWidget(
      {Key? key, required Animation<double> animation, required this.child})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: animation.value,
      alignment: Alignment.center,
      child: child,
    );
  }
}
