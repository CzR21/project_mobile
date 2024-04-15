import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/carrinho_model.dart';
import 'package:project_mobile/data/models/endereco_model.dart';

class AppMock extends ChangeNotifier{

  static EnderecoModel _endereco = EnderecoModel(
    longadouro: 'Rua dos bobos',
    numero: 0,
    bairro: "Centro",
    cidade: 'Ponta Grossa',
    estado: 'Paraná'
  );

  static List<CarrinhoModel> _carrinho = [];

  EnderecoModel get endereco => _endereco;

  List<CarrinhoModel> get carrinho => _carrinho;

  void trocarEndereco(EnderecoModel endereco) {
    _endereco = endereco;
    notifyListeners();
  }

  void addCarrinho(CarrinhoModel carrinho){
    _carrinho.add(carrinho);
    notifyListeners();
  }

}