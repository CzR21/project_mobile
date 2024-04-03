import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mobile/blocs/restaurante/restaurante_bloc.dart';
import 'package:project_mobile/helpers/bottom_sheet_helper.dart';
import 'package:project_mobile/pages/home/widgets/endereco_bottom_sheet.dart';
import 'package:project_mobile/pages/home/widgets/restaurante_widget.dart';
import 'package:project_mobile/data/models/restaurante_model.dart';
import 'package:project_mobile/helpers/date_helper.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import '../../blocs/restaurante/restaurante_state.dart';
import '../../components/buttons/app_icon_buttom_component.dart';
import 'widgets/categoria_widget.dart';
import '../../components/textfields/app_textfield_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();

  final Map<String, String> _categorias = {
    'Pizza': AppAssets.pizzaImage,
    'Lanche': AppAssets.hamburguerImage,
    'Japonesa': AppAssets.japonesaImage,
    'Brasileira': AppAssets.brasileiraImage,
    'Bebidas': AppAssets.bebidasImage,
    'Doces': AppAssets.boloImage,
    'Sorvete': AppAssets.sorveteImage,
  };

  List<RestauranteModel> _restaurantes = List.empty(growable: true);

  final RestauranteBloc _restauranteBloc = RestauranteBloc();

  @override
  void initState() {
    _restauranteBloc.add(GetPrincipaisRestaurantesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, inner) => [
          SliverAppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () => BottomSheetHelper.show(context: context, isScrollable: true, child: const EnderecoBottomSheet(), ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.locationIcon,
                    width: 25,
                    color: AppColors.iconOrangeColor,
                  ),
                  const SizedBox(width: 5,),
                  Text('Rua dos bobos, 0', style: AppFonts.boldDefault.copyWith(color: AppColors.textDarkColor),)
                ],
              ),
            ),
            backgroundColor: AppColors.backgroundColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AppIconButtomComponent(
                  icon: AppAssets.drawerIcon,
                  backgroundColor: AppColors.greyLiteColor,
                  color: AppColors.darkColor,
                  width: 45,
                  iconWidth: 25,
                  function: () => Navigator.of(context).pop()
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: AppIconButtomComponent(
                    icon: AppAssets.bagIcon,
                    backgroundColor: AppColors.darkColor,
                    color: AppColors.textWhiteColor,
                    width: 55,
                    iconWidth: 30,
                    function: () => Navigator.of(context).pop()
                ),
              )
            ],
            leadingWidth: 75,
            elevation: 0,
            toolbarHeight: 55,
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Olá, Nome usuário, ",
                    style: AppFonts.subTitle2.copyWith(color: AppColors.textDarkColor),
                    children: [
                      TextSpan(
                        text: DateHelper.buscarMensagemDia,
                        style: AppFonts.subTitle2.copyWith(color: AppColors.textDarkColor, fontWeight: FontWeight.w700),
                      )
                    ]
                  ),
                ),

                const SizedBox(height: 20,),

                AppTextFieldComponent(
                  controller: _searchController,
                  hint: 'Pesquisar',
                  prefixIcon: AppAssets.searchIcon,
                ),

                const SizedBox(height: 40,),

                Text('Categorias', style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),),

                const SizedBox(height: 20,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categorias.entries.map((entry) => Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: CategoriaWidget(nome: entry.key, image: entry.value,),
                    )).toList()
                  ),
                ),

                const SizedBox(height: 40,),

                Text('Principais restaurantes', style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),),

                BlocConsumer<RestauranteBloc, RestauranteState>(
                  bloc: _restauranteBloc,
                  listener: (context, state) {
                    if (state is SuccessGetPrincipaisRestaurantesState) {
                      setState(() => _restaurantes = state.model);
                    }
                  },
                  builder: (context, state) {
                    if(state is SuccessGetPrincipaisRestaurantesState){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _restaurantes.map((e) => RestauranteWidget(model: e)).toList(),
                      );
                    }else if(state is ErrorGetPrincipaisRestaurantesState){
                      //TODO: Tratar erro dps
                      return Text('Erro!', style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),);
                    }else{
                      return const LinearProgressIndicator(color: AppColors.orangeDarkColor,);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
