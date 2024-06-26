import 'package:flutter/material.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/data/models/carrinho_model.dart';
import 'package:project_mobile/data/models/produto_model.dart';
import 'package:project_mobile/helpers/toasty_helper.dart';
import 'package:provider/provider.dart';

class ProdutoWidget extends StatefulWidget {
  final model;
  const ProdutoWidget({super.key, required this.model});

  @override
  State<ProdutoWidget> createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          '${widget.model.key} (${widget.model.value.length})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.model.value.length,
          itemBuilder: (context, index) {
            return Card(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/produto/${widget.model.value[index].imagem}")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Text(
                    widget.model.value[index].nome,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "R\$${widget.model.value[index].preco}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.orange),
                            minimumSize: MaterialStatePropertyAll(Size(20, 20)),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(2))),
                        iconSize: 20,
                        onPressed: () {
                          // TODO: informar o usuário que foi adicionado
                          setState(() {
                            
                            var provider = Provider.of<AppMock>(context, listen: false);
                            var carrinho = provider.carrinho;
                            ProdutoModel newProduto = widget.model.value[index];

                            try {
                              final filter = carrinho.firstWhere((element) => element.produto == newProduto);
                              filter.quantidade++;
                            } catch (e) {
                              print(e);
                              String lastId = carrinho.isNotEmpty
                                  ? carrinho[carrinho.length - 1].id
                                  : '0';
                              provider.addCarrinho(
                                CarrinhoModel(
                                  id: "${int.parse(lastId) + 1}",
                                  produto: newProduto,
                                  quantidade: 1,
                                ),
                              );
                            }
                          });

                          ToastHelper.showMessage(context: context, messageType: MessageType.success , message: 'Produto adicionado ao carrinho!');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ));
          },
        ),
      ],
    );
  }
}
