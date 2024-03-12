import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_mobile/blocs/restaurante/restaurante_bloc.dart';
import 'package:project_mobile/components/produtos/app_restaurante_component.dart';
import 'package:project_mobile/data/models/restaurante_model.dart';
import 'package:project_mobile/helpers/date_helper.dart';
import 'package:project_mobile/settings/app_assets.dart';
import 'package:project_mobile/settings/app_colors.dart';
import 'package:project_mobile/settings/app_fonts.dart';
import 'package:bloc/bloc.dart';
import '../../blocs/restaurante/restaurante_state.dart';
import '../../components/produtos/app_categorioa_component.dart';
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
    'Árabe': AppAssets.arabeImage,
    'Brasileira': AppAssets.brasileiraImage,
    'Pastel': AppAssets.pastelImage,
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
      appBar: AppBar(
        
      ),
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
                    child: AppCategoriaComponent(nome: entry.key, image: entry.value,),
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
                      children: _restaurantes.map((e) => AppRestauranteComponent(model: e)).toList(),
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
    );
  }
}
