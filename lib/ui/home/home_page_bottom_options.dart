import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class HomePageBottomOptions extends StatelessWidget {
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;
  const HomePageBottomOptions({Key? key, this.onFlip, this.onEnterEditMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onEnterEditMode,
          icon: Icon(
            Icons.settings,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(),
        ),
      ],
    );
  }
}
