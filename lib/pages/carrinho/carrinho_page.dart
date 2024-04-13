import 'package:flutter/material.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_text_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/helpers/bottom_sheet_helper.dart';
import 'package:project_mobile/helpers/converter_helper.dart';
import 'package:project_mobile/pages/home/widgets/endereco_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../data/models/endereco_model.dart';
import '../../data/models/produto_model.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
    
  late List<ProdutoModel> produtos = [
    ProdutoModel(
      id: '12',
      nome: 'Brownie de Chocolate',
      preco: 7.99,
      descricao: 'Porção',
      imagem: 'brownie.png',
      categoria: CategoriaProduto.sobremesa,
    ),
    ProdutoModel(
      id: '13',
      nome: 'Temaki de Atum',
      preco: 14.25,
      descricao: 'Porção',
      imagem: 'temaki_atum.png',
      categoria: CategoriaProduto.sushi,
    ),
    ProdutoModel(
      id: '14',
      nome: 'Creme de Baunilha',
      preco: 6.99,
      descricao: 'sorvete',
      imagem: 'creme_baunilha.png',
      categoria: CategoriaProduto.sorvete,
    ),
    ProdutoModel(
      id: '15',
      nome: 'Yakissoba de Frango',
      preco: 17.50,
      descricao: 'Porção',
      imagem: 'yakissoba.png',
      categoria: CategoriaProduto.refeicao,
    ),
  ];

  late EnderecoModel _endereco;

  double _calcularTotal() {
    double total = 0;

    produtos.forEach((element) => total += (element.preco * element.quntidade));

    return total;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _endereco = Provider.of<AppMock>(context).endereco;

    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                AppIconButtomComponent(
                  icon: AppAssets.arrowBackIcon,
                  color: AppColors.textWhiteColor,
                  backgroundColor: AppColors.darkColor,
                  iconWidth: 20,
                  function: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 15,),
                Expanded(child: Text("Carrinho", style: AppFonts.subTitle.copyWith(color: AppColors.textWhiteColor))),
                AppTextButtomComponent(
                  text: 'LIMPAR',
                  function: () => {},
                  style: AppFonts.linkLarge.copyWith(color: AppColors.textOrangeColor, decorationColor: AppColors.textOrangeColor)
                )
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...produtos.map((e) => _buildProduto(e))
                  ],
                ),
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('ENDEREÇO DE ENTREGA',style: AppFonts.regularLarge.copyWith(color: AppColors.textGreyColor),),
                    const Spacer(),
                    AppTextButtomComponent(
                      text: 'EDITAR',
                      function: () => BottomSheetHelper.show(context: context, isScrollable: true, child: const EnderecoBottomSheet(),),
                      style: AppFonts.linkLarge.copyWith(color: AppColors.textOrangeColor, decorationColor: AppColors.textOrangeColor)
                    )
                  ],
                ),

                const SizedBox(height: 15,),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyLiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(_endereco.toString(), style: AppFonts.boldDefault.copyWith(color: AppColors.textGreyColor),),
                ),

                const SizedBox(height: 30,),

                RichText(
                  text: TextSpan(
                    text: 'TOTAL:',
                    style: AppFonts.regularLarge.copyWith(color: AppColors.textGreyColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: ConverterHelper.doubleParaReal(_calcularTotal()),
                        style: AppFonts.subTitle.copyWith(color: AppColors.textDarkColor),
                      )
                    ]
                  )
                ),

                const SizedBox(height: 30,),

                AppButtomComponent(
                  onPressed: (){},
                  text: 'Finalizar pedido',
                  primaryColor: AppColors.orangeDarkColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProduto(ProdutoModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.darkColor,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Image.asset('assets/images/${model.imagem}'),
          ),
          const SizedBox(width: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width - 160,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.nome, style: AppFonts.subTitle2.copyWith(color: AppColors.textWhiteColor),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text((model.preco * model.quntidade).toString(), style: AppFonts.boldLarge.copyWith(color: AppColors.textWhiteColor),),
                    _buildEditCard(model),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditCard(ProdutoModel model) => Row(
    children: [
      AppIconButtomComponent(
        icon: AppAssets.minusIcon,
        color: AppColors.textWhiteColor,
        backgroundColor: AppColors.darkColor,
        iconWidth: 15,
        width: 30,
        function: () { if(model.quntidade > 1) setState(() => model.quntidade--);}
      ),
      const SizedBox(width: 10,),
      Text(model.quntidade.toString(), style: AppFonts.regularLarge.copyWith(color: AppColors.textWhiteColor),),
      const SizedBox(width: 10,),
      AppIconButtomComponent(
        icon: AppAssets.plusIcon,
        color: AppColors.textWhiteColor,
        backgroundColor: AppColors.darkColor,
        iconWidth: 15,
        width: 30,
        function: () { if(model.quntidade < 10) setState(() => model.quntidade++);}
      ),
    ],
  );
}
