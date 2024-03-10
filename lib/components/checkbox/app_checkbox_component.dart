import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/settings/app_assets.dart';
import 'package:project_mobile/settings/app_colors.dart';

class AppCheckBoxComponent extends StatefulWidget {

  final bool value;
  final Function function;
  final Widget? child;

  const AppCheckBoxComponent({
    super.key,
    required this.value,
    required this.function,
    this.child
  });

  @override
  State<AppCheckBoxComponent> createState() => _AppCheckBoxComponentState();
}

class _AppCheckBoxComponentState extends State<AppCheckBoxComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => widget.function.call(),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: widget.value ? AppColors.orangeDarkColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: widget.value ? AppColors.orangeLiteColor : AppColors.greyColor)
            ),
            child: SvgPicture.asset(
              AppAssets.checkIcon,
              fit: BoxFit.contain,
              color: widget.value ? AppColors.orangeLiteColor : Colors.transparent,
            )
          ),
        ),
        SizedBox(width: widget.child == null ? 0 : 5,),
        Container(
          child: widget.child,
        )
      ],
    );
  }
}
