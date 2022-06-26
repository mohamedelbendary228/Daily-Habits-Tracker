import 'package:flutter/material.dart';

class CustomFadeTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> opacityAnimation;
  CustomFadeTransition({
    Key? key,
    required Animation<double> animation,
    required this.child,
  })  : opacityAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: child,
    );
  }
}
