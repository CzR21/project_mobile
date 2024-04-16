import 'package:project_mobile/data/models/produto_model.dart';

class CarrinhoModel{
  String id;
  int quantidade;
  ProdutoModel produto;

  CarrinhoModel({
    required this.id,
    required this.quantidade,
    required this.produto
  });
}