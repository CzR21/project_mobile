import 'package:flutter/material.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_text_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/data/models/carrinho_model.dart';
import 'package:project_mobile/helpers/bottom_sheet_helper.dart';
import 'package:project_mobile/helpers/converter_helper.dart';
import 'package:project_mobile/helpers/toasty_helper.dart';
import 'package:project_mobile/pages/home/widgets/endereco_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../data/models/endereco_model.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}


class _CarrinhoPageState extends State<CarrinhoPage> {

  late List<CarrinhoModel> _carrinho;
  late EnderecoModel _endereco;
  late AppMock _provider;

  double _calcularTotal() {
    double total = 0;

    _carrinho.forEach((element) => total += element.produto != null
        ? (element.produto.preco * element.quantidade)
        : 0);

    return total;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<AppMock>(context, listen: true);
    _endereco = _provider.endereco;
    _carrinho = _provider.carrinho;

    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
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
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text("Carrinho",
                        style: AppFonts.subTitle
                            .copyWith(color: AppColors.textWhiteColor))),
                AppTextButtomComponent(
                    text: 'LIMPAR',
                    function: () => _provider.limparCarrinho(),
                    style: AppFonts.linkLarge.copyWith(
                        color: AppColors.textOrangeColor,
                        decorationColor: AppColors.textOrangeColor))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [..._carrinho.map((e) => _buildProduto(e))],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ENDEREÇO DE ENTREGA',
                      style: AppFonts.regularLarge
                          .copyWith(color: AppColors.textGreyColor),
                    ),
                    const Spacer(),
                    AppTextButtomComponent(
                        text: 'EDITAR',
                        function: () => BottomSheetHelper.show(
                              context: context,
                              isScrollable: true,
                              child: const EnderecoBottomSheet(),
                            ),
                        style: AppFonts.linkLarge.copyWith(
                            color: AppColors.textOrangeColor,
                            decorationColor: AppColors.textOrangeColor))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyLiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _endereco.toString(),
                    style: AppFonts.boldDefault
                        .copyWith(color: AppColors.textGreyColor),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                    text: TextSpan(
                        text: 'TOTAL:',
                        style: AppFonts.regularLarge
                            .copyWith(color: AppColors.textGreyColor),
                        children: <TextSpan>[
                      TextSpan(
                        text: ConverterHelper.doubleParaReal(_calcularTotal()),
                        style: AppFonts.subTitle
                            .copyWith(color: AppColors.textDarkColor),
                      )
                    ])),
                const SizedBox(
                  height: 30,
                ),
                AppButtomComponent(
                  onPressed: () => _carrinho.isEmpty ? null : Navigator.of(context).pushReplacementNamed(AppRoutes.pedido) ,
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

  Widget _buildProduto(CarrinhoModel model) {
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
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset('assets/images/produto/${model.produto.imagem}'),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 160,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.produto.nome,
                  style: AppFonts.subTitle2
                      .copyWith(color: AppColors.textWhiteColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      (model.produto.preco * model.quantidade).toString(),
                      style: AppFonts.boldLarge
                          .copyWith(color: AppColors.textWhiteColor),
                    ),
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

  Widget _buildEditCard(CarrinhoModel model) => Row(
        children: [
          AppIconButtomComponent(
              icon: AppAssets.minusIcon,
              color: AppColors.textWhiteColor,
              backgroundColor: AppColors.darkColor,
              iconWidth: 15,
              width: 30,
              function: () {
                if (model.quantidade > 1) {
                  _provider.alterarQuantidade(_carrinho.indexOf(model), model.quantidade - 1);
                } else {
                  _provider.removerCarrinho(_carrinho.indexOf(model));
                  ToastHelper.showMessage(context: context, messageType: MessageType.error, message: "Produto removido com sucesso!");
                }
              }),
          const SizedBox(
            width: 10,
          ),
          Text(
            model.quantidade.toString(),
            style:
                AppFonts.regularLarge.copyWith(color: AppColors.textWhiteColor),
          ),
          const SizedBox(
            width: 10,
          ),
          AppIconButtomComponent(
              icon: AppAssets.plusIcon,
              color: AppColors.textWhiteColor,
              backgroundColor: AppColors.darkColor,
              iconWidth: 15,
              width: 30,
              function: () {
                if (model.quantidade < 10) setState(() => model.quantidade++);
              }),
        ],
      );
}
