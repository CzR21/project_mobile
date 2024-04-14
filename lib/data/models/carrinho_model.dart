import 'package:project_mobile/data/models/produto_model.dart';

class CarrinhoModel{
  String id;
  String produtoId;
  int quantidade;
  ProdutoModel? produto;

  CarrinhoModel({
    required this.id,
    required this.produtoId,
    required this.quantidade,
    this.produto
  });
}