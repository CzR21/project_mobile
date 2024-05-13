import 'package:flutter/material.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import 'app_icon_buttom_component.dart';

class AppBackButtomComnponent extends StatelessWidget {

  final Color backgroundColor;

  const AppBackButtomComnponent({
    super.key,
    this.backgroundColor = AppColors.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppIconButtomComponent(
          icon: AppAssets.arrowBackIcon,
          backgroundColor: backgroundColor,
          color: AppColors.darkColor,
          width: 45,
          function: () => Navigator.of(context).pop()
      ),
    );
  }
}
