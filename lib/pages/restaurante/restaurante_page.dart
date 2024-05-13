import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_mobile/blocs/produto/produto_bloc.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/data/models/produto_model.dart';
import "package:project_mobile/data/models/restaurante_model.dart";
import 'package:project_mobile/pages/restaurante/widgets/produtos_widget.dart';
import 'package:provider/provider.dart';

class RestaurantePage extends StatefulWidget {
  final RestauranteModel restaurante;
  const RestaurantePage({super.key, required this.restaurante});

  @override
  _RestaurantePageState createState() => _RestaurantePageState();
}

class _RestaurantePageState extends State<RestaurantePage> {
  late AppMock _provider;
  final ProdutoBloc _produtoBloc = ProdutoBloc();
  Map<String, List<ProdutoModel>> _produtosCategoria = {};

  @override
  void initState() {
    super.initState();
    _produtoBloc.add(GetProdutoEvent(restauranteId: widget.restaurante.id));
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<AppMock>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: Stack(
              children: [
                AppIconButtomComponent(
                  icon: AppAssets.bagIcon,
                  backgroundColor: AppColors.darkColor,
                  color: AppColors.textWhiteColor,
                  width: 55,
                  iconWidth: 30,
                  function: () =>
                      Navigator.of(context).pushNamed(AppRoutes.carrinho),
                ),
                Visibility(
                  visible: _provider.carrinho.length > 0,
                  child: Positioned(
                      right: 1,
                      top: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.orangeDarkColor,
                            borderRadius: BorderRadius.circular(999)),
                        child: Text(
                          _provider.carrinho.length.toString(),
                          style: AppFonts.regularSmall
                              .copyWith(color: AppColors.textWhiteColor),
                        ),
                      )),
                )
              ],
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
                        "assets/images/restaurantes/${widget.restaurante.imagem}"),
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
              BlocConsumer<ProdutoBloc, ProdutoState>(
                  bloc: _produtoBloc,
                  listener: (context, state) {
                    if (state is SuccessGetProdutosState) {
                      setState(() => _produtosCategoria = state.model);
                    }
                  },
                  builder: (context, state) {
                    if (state is SuccessGetProdutosState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _produtosCategoria.entries
                            .map<Widget>((entry) => ProdutoWidget(model: entry))
                            .toList(),
                      );
                    } else if (state is ErrorGetProdutosState) {
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
                    } else {
                      return const LinearProgressIndicator(
                        color: AppColors.orangeDarkColor,
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
