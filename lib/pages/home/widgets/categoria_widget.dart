import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';

class CategoriaWidget extends StatelessWidget {

  final String nome;
  final String image;

  const CategoriaWidget({
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
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                image,
                height: 20,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Text(nome, style: AppFonts.subTitleBold.copyWith(color: AppColors.textDarkColor, fontSize: 18),)
      ],
    );
  }

  Color get backgroundColor{
    switch(nome) {
      case 'Pizza': return AppColors.liteYellowColor;
      case 'Lanche': return AppColors.liteOrangeColor;
      case 'Japonesa': return AppColors.liteReColor ;
      case 'Brasileira': return AppColors.liteGreenColor;
      case 'Bebidas': return AppColors.liteLiteBlueColor;
      case 'Doces': return AppColors.liteBlueColor;
      case 'Sorvete': return AppColors.litePurpleColor;
      default: return AppColors.backgroundColor;
    }
  }
}
