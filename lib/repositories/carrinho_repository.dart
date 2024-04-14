import 'package:project_mobile/data/models/carrinho_model.dart';

class CarrinhoRepository {
  static List<CarrinhoModel> listaCarrinho = [
    CarrinhoModel(id: '1',produtoId: '1',quantidade: 2),
    CarrinhoModel(id: '1',produtoId: '2',quantidade: 1),
    CarrinhoModel(id: '1',produtoId: '3',quantidade: 1),
  ];
}
