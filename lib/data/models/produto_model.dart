import 'package:cloud_firestore/cloud_firestore.dart';

enum CategoriaProduto {
  Lanche,
  Sushi,
  Bebida,
  Sobremesa,
  Sorvete,
  Refeicao,
}

class ProdutoModel {
  String id;
  String nome;
  double preco;
  String descricao;
  String imagem;
  String? observacao;
  CategoriaProduto categoria;
  String restauranteId;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagem,
    this.observacao,
    required this.categoria,
    required this.restauranteId,
  });

  factory ProdutoModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    CategoriaProduto categoria = CategoriaProduto.values
        .firstWhere((cat) => cat.name == data['categoria']);

    return ProdutoModel(
      id: doc.id,
      nome: data['nome'] ?? '',
      preco: data['preco'] ?? '',
      descricao: data['descricao'] ?? '',
      imagem: data['imagem'] ?? '',
      observacao: data['observacao'] ?? '',
      categoria: categoria,
      restauranteId: data['restauranteId'] ?? '',
    );
  }
}
