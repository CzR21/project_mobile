import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:project_mobile/data/models/carrinho_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  List<CarrinhoModel> carrinho = [];

  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readCarrinho();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readCarrinho(){
    String carrinhoString = _prefs.getString("carrinho")?? "";

    carrinho = jsonDecode(carrinhoString);

    notifyListeners();
  }

  setCarrinho(List<CarrinhoModel> newCarrinho) async{
    String carrinhoString = jsonEncode(newCarrinho);
    await _prefs.setString("carrinho", carrinhoString);
    await _readCarrinho();
  }
}
