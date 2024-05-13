import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/carrinho_model.dart';
import 'package:project_mobile/data/models/endereco_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppMock extends ChangeNotifier {
  late SharedPreferences _prefs;
  static List<CarrinhoModel> _carrinho = [];
  static EnderecoModel _endereco = EnderecoModel(
      longadouro: 'Rua dos bobos',
      numero: 0,
      bairro: "Centro",
      cidade: 'Ponta Grossa',
      estado: 'Paraná');

  AppMock() {
    _startSettings();
  }

  _startSettings() async{
    _prefs = await SharedPreferences.getInstance();
    await _readCarrinho();
  }

  EnderecoModel get endereco => _endereco;

  void trocarEndereco(EnderecoModel endereco) {
    _endereco = endereco;
    notifyListeners();
  }

  // -- Carrinho --
  _readCarrinho() {
    String carrinhoString = _prefs.getString("carrinho")?? "";

    if (carrinhoString != "") {
      _carrinho = jsonDecode(carrinhoString);
      notifyListeners();
    }
  }

  List<CarrinhoModel> get carrinho => _carrinho;

  void addCarrinho(CarrinhoModel carrinho) {
    _carrinho.add(carrinho);
    updateCarrinho();
    notifyListeners();
  }

  void removerCarrinho(int index) {
    _carrinho.removeAt(index);
    updateCarrinho();
    notifyListeners();
  }

  void limparCarrinho() {
    _carrinho.clear();
    updateCarrinho();
    notifyListeners();
  }

  void alterarQuantidade(int index, int quantidade) {
    _carrinho.elementAt(index).quantidade = quantidade;
    updateCarrinho();
    notifyListeners();
  }

  void updateCarrinho() async {
    await _prefs.setString("carrinho", jsonEncode(_carrinho));
  }
  // -- FIM Carrinho --
}
