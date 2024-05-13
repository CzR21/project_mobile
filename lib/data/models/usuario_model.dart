import 'dart:convert';

class UsuarioModel {

  String id;
  String nome;
  String email;
  String dataCadastro;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.dataCadastro
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'dataCadastro': dataCadastro,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      dataCadastro: map['dataCadastro'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) => UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
