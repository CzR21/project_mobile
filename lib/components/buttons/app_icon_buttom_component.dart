import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_colors.dart';

class AppIconButtomComponent extends StatefulWidget{

  final String icon;
  final Color color;
  final Color? backgroundColor;
  final double width;
  final double iconWidth;
  final Function function;
  final double borderRadios;
  final Color? borderColor;

  const AppIconButtomComponent({
    super.key,
    required this.icon,
    required this.color,
    this.backgroundColor,
    this.width = 45,
    this.iconWidth = 15,
    required this.function,
    this.borderRadios = 999,
    this.borderColor,
  });


  @override
  State<AppIconButtomComponent> createState() => _AppIconButtomComponentState();
}

class _AppIconButtomComponentState extends State<AppIconButtomComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.function.call(),
      child: Container(
        width: widget.width,
        height: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: widget.borderColor == null ? null : Border.all(color: widget.borderColor!),
          borderRadius: BorderRadius.circular(widget.borderRadios),
          color: widget.backgroundColor ?? AppColors.greyLiteColor
        ),
        child: SvgPicture.asset(
          widget.icon,
          width: widget.iconWidth,
          color: widget.color,
        ),
      ),
    );
  }
}
