import "package:flutter/material.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/data/models/produto_model.dart';
import "package:project_mobile/data/models/restaurante_model.dart";
import 'package:project_mobile/pages/restaurante/widgets/produtos_widget.dart';
import 'package:project_mobile/repositories/produtos_repository.dart';

class RestaurantePage extends StatefulWidget {
  final RestauranteModel restaurante;
  const RestaurantePage({super.key, required this.restaurante});

  @override
  _RestaurantePageState createState() => _RestaurantePageState();
}

class _RestaurantePageState extends State<RestaurantePage> {
  @override
  void initState() {
    super.initState();
  }

  getProdutosCategoria() {
    try {
      final produtos = ProdutosRepository.listaProdutos.where(
        (element) => element.empresaId == widget.restaurante.id,
      );

      if(produtos.isEmpty){
        return null;
      }

      Map<String, List<ProdutoModel>> produtosCategoria = {};

      for (var produto in produtos) {
        produtosCategoria
            .putIfAbsent(produto.categoria.name, () => [])
            .add(produto);
      }

      return produtosCategoria;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final produtosCategoria = getProdutosCategoria();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 10),
            child: AppIconButtomComponent(
              icon: AppAssets.bagIcon,
              backgroundColor: AppColors.darkColor,
              color: AppColors.textWhiteColor,
              width: 55,
              iconWidth: 30,
              function: () =>
                  Navigator.of(context).pushNamed(AppRoutes.carrinho),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/restaurantes/${widget.restaurante.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.restaurante.nome,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.restaurante.descricao,
                style: const TextStyle(fontSize: 14, color: Color(0xffA0A5BA)),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  _iconText(
                      AppAssets.starIcon, widget.restaurante.nota.toString()),
                  const SizedBox(
                    width: 15,
                  ),
                  _iconText(
                      AppAssets.carIcon, widget.restaurante.frete.toString()),
                  const SizedBox(
                    width: 15,
                  ),
                  _iconText(AppAssets.watchIcon, widget.restaurante.tempo),
                ],
              ),
              Builder(builder: (context) {
                if (produtosCategoria != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: produtosCategoria.entries
                        .map<Widget>((entry) => ProdutoWidget(model: entry))
                        .toList(),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        SvgPicture.asset(
                          AppAssets.notFoundIcon,
                          width: 100,
                        ),
                        Text(
                          'Nenhum produto encontrado!',
                          style: AppFonts.regularLarge
                              .copyWith(color: AppColors.darkColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
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
