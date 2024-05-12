import 'package:cloud_firestore/cloud_firestore.dart';

enum Categoria{
  pizza,
  hamburguer,
  japonesa,
  bebidas,
  brasileira,
  pastel,
  doces,
  sorvetes,
}

class RestauranteModel{

  String id;
  String nome;
  List<Categoria> categorias;
  double frete;
  String tempo;
  String imagem;
  double nota;
  String descricao;

  RestauranteModel({
    required this.id,
    required this.nome,
    required this.categorias,
    required this.frete,
    required this.tempo,
    required this.imagem,
    required this.nota,
    required this.descricao,
  });

  String get categoriasString{
    return categorias.map((e) => e.name).toList().join(' - ');
  }

  factory RestauranteModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Categoria> categorias = (data['categorias'] as List)
        .map((e) => Categoria.values.firstWhere((cat) => cat.name == e))
        .toList();

    return RestauranteModel(
      id: doc.id,
      nome: data['nome'] ?? '',
      categorias: categorias,
      frete: data['frete'] ?? '',
      tempo: data['tempo'] ?? '',
      imagem: data['imagem'] ?? '',
      nota: data['nota'] ?? '',
      descricao: data['descricao'] ?? '',
    );
  }
}