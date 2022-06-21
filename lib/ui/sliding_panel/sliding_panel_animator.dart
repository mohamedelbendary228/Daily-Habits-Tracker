import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/animations/animation_controller_state.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';

class SlidingPanelAnimator extends StatefulWidget {
  final SlideDirection direction;
  final Widget child;
  const SlidingPanelAnimator({
    Key? key,
    required this.direction,
    required this.child,
  }) : super(key: key);

  @override
  State<SlidingPanelAnimator> createState() =>
      _SlidingPanelAnimatorState(Duration(milliseconds: 200));
}

class _SlidingPanelAnimatorState
    extends AnimationControllerState<SlidingPanelAnimator> {
  _SlidingPanelAnimatorState(Duration duration) : super(duration);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
