import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/data/models/categoria_model.dart';

class CategoriaWidget extends StatelessWidget {

  final CategoriaModel model;

  const CategoriaWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(4, 8),
              ),
            ]
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: model.backgroundColor.withOpacity(model.select ? 0.9 : 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  model.image,
                  height: 20,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Text(model.nome, style: AppFonts.subTitleBold.copyWith(color: model.select ? model.backgroundColor.withOpacity(1) : AppColors.textDarkColor, fontSize: 18),)
      ],
    );
  }


}
