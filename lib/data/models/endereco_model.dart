// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:project_mobile/config/app_assets.dart';
import 'package:uuid/uuid.dart';

enum TipoEndereco { casa, trabalho, none }

class EnderecoModel {

  String id;
  String idUsuario;
  String longadouro;
  int numero;
  String? complemento;
  String bairro;
  String cidade;
  String estado;
  String? apelido;
  TipoEndereco tipoEndereco;

  EnderecoModel({
    required this.id,
    required this.idUsuario,
    required this.longadouro,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.apelido,
    this.tipoEndereco = TipoEndereco.none
  });

  String get image {
    switch(tipoEndereco){
      case TipoEndereco.casa: return AppAssets.homeIcon;
      case TipoEndereco.trabalho: return AppAssets.buildingIcon;
      case TipoEndereco.none: return AppAssets.watchIcon;
    }
  }

  @override
  String toString() {
    return '$longadouro, $numero${complemento == null ? '' : ' - $complemento'} - $bairro, $cidade, - $estado';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUsuario': idUsuario,
      'longadouro': longadouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'apelido': apelido,
      'tipoEndereco': tipoEndereco.name,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      id: map['id'] as String,
      idUsuario: map['idUsuario'] as String,
      longadouro: map['longadouro'] as String,
      numero: map['numero'] as int,
      complemento: map['complemento'] ,
      bairro: map['bairro'] as String,
      cidade: map['cidade'] as String,
      estado: map['estado'] as String,
      apelido: map['apelido'] != null ? map['apelido'] as String : null,
      tipoEndereco: TipoEndereco.values.firstWhere((element) => element.name == map['tipoEndereco']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) => EnderecoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
