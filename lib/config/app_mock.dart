import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/endereco_model.dart';

class AppMock extends ChangeNotifier{

  static EnderecoModel _endereco = EnderecoModel(
    longadouro: 'Rua dos bobos',
    numero: 0,
    bairro: "Centro",
    cidade: 'Ponta Grossa',
    estado: 'Paraná'
  );

  EnderecoModel get endereco => _endereco;

  void trocarEndereco(EnderecoModel endereco) {
    _endereco = endereco;
    notifyListeners();
    print(_endereco);
  }

}