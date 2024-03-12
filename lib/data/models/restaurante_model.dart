enum Categoria{
  pizza,
  lanche,
  japonesa,
  arabe,
  brasileira,
  pastel,
  doces,
  sorvete,
}

class RestauranteModel{

  String id;
  String nome;
  List<Categoria> categorias;
  double frete;
  String tempo;
  String image;
  double nota;

  RestauranteModel({
    required this.id,
    required this.nome,
    required this.categorias,
    required this.frete,
    required this.tempo,
    required this.image,
    required this.nota
  });

  String get categoriasString{
    return categorias.map((e) => e.name).toList().join(' - ');
  }
}