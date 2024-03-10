import 'package:flutter/material.dart';
import 'package:project_mobile/settings/app_colors.dart';
import 'package:project_mobile/settings/app_fonts.dart';

class AppTextButtomComponent extends StatefulWidget {

  final String text;
  final Function function;
  final TextStyle? style;

  const AppTextButtomComponent({super.key, required this.text, required this.function, this.style});

  @override
  State<AppTextButtomComponent> createState() => _AppTextButtomComponentState();
}

class _AppTextButtomComponentState extends State<AppTextButtomComponent> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.function.call(),
      child: Text(widget.text, style: widget.style ?? AppFonts.regularLarge.copyWith(color: AppColors.textOrangeColor),),
    );
  }
}
