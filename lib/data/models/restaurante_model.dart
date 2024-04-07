import 'package:project_mobile/data/models/produto_model.dart';

enum Categoria{
  Pizza,
  Lanche,
  Japonesa,
  Arabe,
  Brasileira,
  Pastel,
  Doces,
  Sorvete,
}

class RestauranteModel{

  String id;
  String nome;
  List<Categoria> categorias;
  double frete;
  String tempo;
  String image;
  double nota;
  String descricao;
  List<String> produtos;

  RestauranteModel({
    required this.id,
    required this.nome,
    required this.categorias,
    required this.frete,
    required this.tempo,
    required this.image,
    required this.nota,
    required this.descricao,
    required this.produtos,    
  });

  String get categoriasString{
    return categorias.map((e) => e.name).toList().join(' - ');
  }
}