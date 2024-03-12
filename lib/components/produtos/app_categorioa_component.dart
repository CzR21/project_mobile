import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project_mobile/settings/app_colors.dart';
import 'package:project_mobile/settings/app_fonts.dart';

class AppCategoriaComponent extends StatelessWidget {

  final String nome;
  final String image;

  const AppCategoriaComponent({
    super.key,
    required this.nome,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
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
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(height: 15,),
        Text(nome, style: AppFonts.subTitleBold.copyWith(color: AppColors.textDarkColor, fontSize: 18),)
      ],
    );
  }
}
