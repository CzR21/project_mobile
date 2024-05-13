import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/data/models/restaurante_model.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/config/app_routes.dart';

class RestauranteWidget extends StatefulWidget {
  final RestauranteModel model;

  const RestauranteWidget({super.key, required this.model});

  @override
  State<RestauranteWidget> createState() => _RestauranteWidgetState();
}

class _RestauranteWidgetState extends State<RestauranteWidget> {
  showRestaurante(RestauranteModel restauranteModel) {
    Navigator.of(context)
        .pushNamed(AppRoutes.restaurante, arguments: restauranteModel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: GestureDetector(
          onTap: () => showRestaurante(widget.model),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(2, 4),
                  ),
                ]),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: const Color.fromARGB(255, 7, 51, 95),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/restaurantes/${widget.model.imagem}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model.nome,
                  style: AppFonts.subTitle
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  widget.model.categoriasString,
                  style: AppFonts.regularLarge
                      .copyWith(color: AppColors.textGreyColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    _iconText(AppAssets.starIcon, widget.model.nota.toString()),
                    const SizedBox(
                      width: 15,
                    ),
                    _iconText(AppAssets.carIcon, widget.model.frete.toString()),
                    const SizedBox(
                      width: 15,
                    ),
                    _iconText(AppAssets.watchIcon, widget.model.tempo),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _iconText(String icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            fit: BoxFit.fill,
            color: AppColors.iconOrangeColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style:
                AppFonts.regularLarge.copyWith(color: AppColors.textDarkColor),
          )
        ],
      );
}
