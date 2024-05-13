import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_contansts.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/repositories/autenticacao_repository.dart';
import 'package:project_mobile/services/firestore_service.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  List<Map<String, dynamic>> opcoes = [
    {
      "text": "Meus pedidos",
      "icon": AppAssets.creditCardIcon,
      "color": AppColors.iconGreenColor,
      "fuction": () => {},
    },
    {
      "text": "Sair",
      "icon": AppAssets.logoutIcon,
      "color": AppColors.iconOrangeColor,
      "fuction": () => AutenticacaoRepository.logout(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: AppColors.orangeLiteColor,
              ),
              child: SvgPicture.asset(
                AppAssets.userIcon,
                width: 50,
                color: AppColors.orangeDarkColor,
              ),
            ),

            const SizedBox(width: 30,),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppConstants.usuario.nome, style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),),
                  Text(AppConstants.usuario.email, style: AppFonts.subTitle2.copyWith(color: AppColors.darkColor),),
                ],
              ),
            ),

          ],
        ),

        const SizedBox(height: 30,),

        Container(
          decoration: BoxDecoration(
            color: AppColors.greyLiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ...opcoes.map((e) => Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: option(text: e['text'], icon: e['icon'], color: e['color'], fuction: e['fuction']),),)
            ],
          ),
        )
      ],
    );
  }

  Widget option({
    required String text,
    required String icon,
    required Color color,
    required Function fuction,
  }){
    return GestureDetector(
      onTap: () => fuction.call(),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(icon, color: color, width: 18,),
          ),
          const SizedBox(width: 10,),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
