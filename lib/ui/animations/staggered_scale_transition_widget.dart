import 'package:flutter/material.dart';

class StaggeredScaleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> scaleAnimation;
  StaggeredScaleTransition(
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
              curve: Curves.easeInOutCubic,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //final animation = listenable as Animation<double>;
    return ScaleTransition(
      scale: scaleAnimation,
      alignment: Alignment.center,
      child: child,
    );
  }
}
