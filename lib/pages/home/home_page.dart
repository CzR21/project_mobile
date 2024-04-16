import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mobile/blocs/restaurante/restaurante_bloc.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/data/models/categoria_model.dart';
import 'package:project_mobile/data/models/endereco_model.dart';
import 'package:project_mobile/helpers/bottom_sheet_helper.dart';
import 'package:project_mobile/pages/home/widgets/endereco_bottom_sheet.dart';
import 'package:project_mobile/pages/home/widgets/restaurante_widget.dart';
import 'package:project_mobile/data/models/restaurante_model.dart';
import 'package:project_mobile/helpers/date_helper.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:provider/provider.dart';
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

  final List<CategoriaModel> _categorias = [
    CategoriaModel(Categoria.pizza),
    CategoriaModel(Categoria.hamburguer),
    CategoriaModel(Categoria.japonesa),
    CategoriaModel(Categoria.brasileira),
    CategoriaModel(Categoria.bebidas),
    CategoriaModel(Categoria.doces),
    CategoriaModel(Categoria.sorvetes),
  ];

  List<RestauranteModel> _restaurantes = List.empty(growable: true);

  final RestauranteBloc _restauranteBloc = RestauranteBloc();

  late EnderecoModel _endereco;
  late AppMock _provider;

  @override
  void initState() {
    _restauranteBloc.add(GetPrincipaisRestaurantesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<AppMock>(context, listen: true);
    _endereco = _provider.endereco;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, inner) => [
          SliverAppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () => BottomSheetHelper.show(context: context, isScrollable: true, child: const EnderecoBottomSheet(), ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationIcon,
                      width: 25,
                      color: AppColors.iconOrangeColor,
                    ),
                    const SizedBox(width: 5,),
                    Flexible(child: Text("${_endereco.longadouro}, ${_endereco.numero}", style: AppFonts.boldDefault.copyWith(color: AppColors.textDarkColor), overflow: TextOverflow.fade,))
                  ],
                ),
              ),
            ),
            backgroundColor: AppColors.backgroundColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: Container(
                width: 55,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyLiteColor, width: 2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: SvgPicture.asset(
                  AppAssets.userIcon,
                  width: 25,
                  color: AppColors.darkColor,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                child: Stack(
                  children: [
                    AppIconButtomComponent(
                      icon: AppAssets.bagIcon,
                      backgroundColor: AppColors.darkColor,
                      color: AppColors.textWhiteColor,
                      width: 55,
                      iconWidth: 30,
                      function: () => Navigator.of(context).pushNamed(AppRoutes.carrinho),
                    ),

                    Positioned(
                      right: 1,
                      top: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.orangeDarkColor,
                          borderRadius: BorderRadius.circular(999)
                        ),
                        child: Text(_provider.carrinho.length.toString(), style: AppFonts.regularSmall.copyWith(color: AppColors.textWhiteColor),),
                      )
                    )
                  ],
                ),
              )
            ],
            leadingWidth: 75,
            elevation: 0,
            toolbarHeight: 65,
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
                  onEdit: (value) => _atualizaLista(),
                ),

                const SizedBox(height: 40,),

                Text('Categorias', style: AppFonts.subTitle.copyWith(color: AppColors.darkColor),),

                const SizedBox(height: 20,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categorias.map((entry) => Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: GestureDetector(
                        onTap: () => _selectRestaurante(entry),
                        child: CategoriaWidget(model: entry,),
                      ),
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
                      if(_restaurantes.isEmpty){
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50,),
                              SvgPicture.asset(AppAssets.notFoundIcon, width: 100,),
                              Text('Nenhum restaurante encontrado!', style: AppFonts.regularLarge.copyWith(color: AppColors.darkColor), textAlign: TextAlign.center,),
                            ],
                          ),
                        );
                      }else{
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _restaurantes.map((e) => RestauranteWidget(model: e)).toList(),
                        );
                      }
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

  _selectRestaurante(CategoriaModel model){
    setState(() => model.select = !model.select);
    _atualizaLista();
  }

  void _atualizaLista(){
    _restauranteBloc.add(GetPrincipaisRestaurantesEvent(search: _searchController.text, categorias: _categorias.where((e) => e.select).map((e) => e.categoria).toList()));
  }
}
