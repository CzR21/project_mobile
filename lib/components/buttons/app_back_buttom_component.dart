import 'package:flutter/material.dart';
import '../../settings/app_assets.dart';
import '../../settings/app_colors.dart';
import 'app_icon_buttom_component.dart';

class AppBackButtomComnponent extends StatelessWidget {

  const AppBackButtomComnponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppIconButtomComponent(
          icon: AppAssets.arrowBackIcon,
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.darkColor,
          width: 45,
          function: () => Navigator.of(context).pop()
      ),
    );
  }
}
