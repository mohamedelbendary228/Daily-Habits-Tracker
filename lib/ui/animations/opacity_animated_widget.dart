import 'package:flutter/material.dart';

class OpacityAnimatedWidget extends AnimatedWidget {
  final Widget child;
  final Animation<double> opacityAnimation;
  OpacityAnimatedWidget(
      {Key? key, required Animation<double> animation, required this.child})
      : opacityAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          ),
        ),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    //final animation = listenable as Animation<double>;
    return Opacity(opacity: opacityAnimation.value, child: child);
  }
}
