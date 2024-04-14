import 'package:project_mobile/data/models/produto_model.dart';

class ProdutosRepository {
  static List<ProdutoModel> listaProdutos = [
    ProdutoModel(
      id: '1',
      nome: 'Coca-Cola Lata',
      preco: 4.0,
      descricao: '350ml',
      imagem: 'coca_cola_350.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: 'fbbbcce0-df7a-4e14-93a0-18b4fd722548'
    ),
    ProdutoModel(
      id: '2',
      nome: 'Tempura de Legumes',
      preco: 12.50,
      descricao: 'Porção',
      imagem: 'tempura_de_legumes.jpg',
      categoria: CategoriaProduto.Lanche,
      empresaId: 'a24dd5a1-8fad-4d13-8a6a-3e9e06e8cf54'
    ),
    ProdutoModel(
      id: '3',
      nome: 'Sashimi de Salmão',
      preco: 18.75,
      descricao: 'Porção',
      imagem: 'sashimi.jpg',
      categoria: CategoriaProduto.Sushi,
      empresaId: 'ec53751b-6517-44d1-b465-934eff65658a'
    ),
    ProdutoModel(
      id: '4',
      nome: 'Mochi de Morango',
      preco: 8.99,
      descricao: 'Porção',
      imagem: 'mochi.jpg',
      categoria: CategoriaProduto.Sobremesa,
      empresaId: '1d9ba73e-75c6-4b9b-a821-4ac02a286209'
    ),
    ProdutoModel(
      id: '5',
      nome: 'Hambúrguer',
      preco: 15.99,
      descricao: 'Porção',
      imagem: 'hamburguer.jpg',
      categoria: CategoriaProduto.Refeicao,
      empresaId: 'a24dd5a1-8fad-4d13-8a6a-3e9e06e8cf54'
    ),
    ProdutoModel(
      id: '6',
      nome: 'Água Mineral',
      preco: 2.50,
      descricao: '500ml',
      imagem: 'agua.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: 'fbbbcce0-df7a-4e14-93a0-18b4fd722548'
    ),
    ProdutoModel(
      id: '7',
      nome: 'Cheesecake de Morango',
      preco: 10.50,
      descricao: 'Fatia',
      imagem: 'cheesecake_morango.jpg',
      categoria: CategoriaProduto.Sobremesa,
      empresaId: '1d9ba73e-75c6-4b9b-a821-4ac02a286209'
    ),
    ProdutoModel(
      id: '8',
      nome: 'Cone de Sorvete de Chocolate',
      preco: 5.99,
      descricao: 'sorvete',
      imagem: 'sorvete_chocolate.jpg',
      categoria: CategoriaProduto.Sorvete,
      empresaId: '29763702-33dc-4318-ac82-73f19b8398eb'
    ),
    ProdutoModel(
      id: '9',
      nome: 'Pizza de Pepperoni',
      preco: 22.99,
      descricao: 'Pizza Inteira',
      imagem: 'pizza_pepperoni.jpg',
      categoria: CategoriaProduto.Refeicao,
      empresaId: 'fbbbcce0-df7a-4e14-93a0-18b4fd722548'
    ),
    ProdutoModel(
      id: '10',
      nome: 'Suco de Laranja Natural',
      preco: 4.50,
      descricao: '300ml',
      imagem: 'suco_laranja.jpg',
      categoria: CategoriaProduto.Bebida,
      empresaId: '487c0902-4932-49cd-9ca0-51f4fe7b42a5'
    ),
    ProdutoModel(
      id: '11',
      nome: 'Sanduíche de Frango Grelhado',
      preco: 11.99,
      descricao: 'Porção',
      imagem: 'sanduiche_frango_grelhado.png',
      categoria: CategoriaProduto.Lanche,
      empresaId: 'a24dd5a1-8fad-4d13-8a6a-3e9e06e8cf54'
    ),
    ProdutoModel(
      id: '12',
      nome: 'Brownie de Chocolate',
      preco: 7.99,
      descricao: 'Porção',
      imagem: 'brownie.jpg',
      categoria: CategoriaProduto.Sobremesa,
      empresaId: '1d9ba73e-75c6-4b9b-a821-4ac02a286209'
    ),
    ProdutoModel(
      id: '13',
      nome: 'Temaki de Atum',
      preco: 14.25,
      descricao: 'Porção',
      imagem: 'temaki_atum.jpg',
      categoria: CategoriaProduto.Sushi,
      empresaId: 'ec53751b-6517-44d1-b465-934eff65658a'
    ),
    ProdutoModel(
      id: '14',
      nome: 'Creme de Baunilha',
      preco: 6.99,
      descricao: 'sorvete',
      imagem: 'sorvete_creme.jpg',
      categoria: CategoriaProduto.Sorvete,
      empresaId: '29763702-33dc-4318-ac82-73f19b8398eb'
    ),
    ProdutoModel(
      id: '15',
      nome: 'Yakissoba de Frango',
      preco: 17.50,
      descricao: 'Porção',
      imagem: 'yakissoba_frango.jpeg',
      categoria: CategoriaProduto.Refeicao,
      empresaId: 'ec53751b-6517-44d1-b465-934eff65658a'
    ),
    ProdutoModel(
      id: '16',
      nome: 'Coca-Cola Lata',
      preco: 4.0,
      descricao: '350ml',
      imagem: 'coca_cola_350.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: '487c0902-4932-49cd-9ca0-51f4fe7b42a5'
    ),
    ProdutoModel(
      id: '17',
      nome: 'Água Mineral',
      preco: 2.50,
      descricao: '500ml',
      imagem: 'agua.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: '487c0902-4932-49cd-9ca0-51f4fe7b42a5'
    ),
    ProdutoModel(
      id: '18',
      nome: 'Coca-Cola Lata',
      preco: 4.0,
      descricao: '350ml',
      imagem: 'coca_cola_350.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: '453a7d24-3116-4afa-9c6b-d06b85c33ed1'
    ),
    ProdutoModel(
      id: '19',
      nome: 'Água Mineral',
      preco: 2.50,
      descricao: '500ml',
      imagem: 'agua.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: '453a7d24-3116-4afa-9c6b-d06b85c33ed1'
    ),
    ProdutoModel(
      id: '20',
      nome: 'Suco de Laranja Natural',
      preco: 4.50,
      descricao: '300ml',
      imagem: 'suco_laranja.jpg',
      categoria: CategoriaProduto.Bebida,
      empresaId: '453a7d24-3116-4afa-9c6b-d06b85c33ed1'
    ),
    ProdutoModel(
      id: '21',
      nome: 'Coca-Cola Lata',
      preco: 4.0,
      descricao: '350ml',
      imagem: 'coca_cola_350.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: 'a2f40cac-cb99-4049-84fe-473a3d590ded'
    ),
    ProdutoModel(
      id: '22',
      nome: 'Água Mineral',
      preco: 2.50,
      descricao: '500ml',
      imagem: 'agua.png',
      categoria: CategoriaProduto.Bebida,
      empresaId: 'a2f40cac-cb99-4049-84fe-473a3d590ded'
    ),
    ProdutoModel(
      id: '23',
      nome: 'Suco de Laranja Natural',
      preco: 4.50,
      descricao: '300ml',
      imagem: 'suco_laranja.jpg',
      categoria: CategoriaProduto.Bebida,
      empresaId: 'a2f40cac-cb99-4049-84fe-473a3d590ded'
    ),
    ProdutoModel(
      id: '24',
      nome: 'Pizza de Pepperoni',
      preco: 22.99,
      descricao: 'Pizza Inteira',
      imagem: 'pizza_pepperoni.jpg',
      categoria: CategoriaProduto.Refeicao,
      empresaId: 'b1fcf79e-f21b-4f7f-9edf-9d87f26d6e2b'
    ),
    ProdutoModel(
      id: '25',
      nome: 'Tempura de Legumes',
      preco: 12.50,
      descricao: 'Porção',
      imagem: 'tempura_de_legumes.jpg',
      categoria: CategoriaProduto.Lanche,
      empresaId: '1902c775-befa-4913-aeff-af20fea13910'
    ),
  ];
}
