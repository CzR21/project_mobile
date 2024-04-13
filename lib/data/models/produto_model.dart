enum CategoriaProduto{
  lanche,
  sushi,
  bebida,
  sobremesa,
  sorvete,
  refeicao,
}


class ProdutoModel{
  String id;
  String nome;
  double preco;
  String descricao;
  String imagem;
  int quntidade;
  String? observacao;
  CategoriaProduto categoria;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagem,
    this.quntidade = 1,
    this.observacao,
    required this.categoria,
  });
}