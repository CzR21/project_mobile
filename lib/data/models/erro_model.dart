import 'dart:convert';
import 'package:dio/dio.dart';

class ErrorModel {

  final String name;
  final String message;
  final int code;

  ErrorModel({
    required this.name,
    required this.message,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'message': message,
      'code': code,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      code: map['code'] ?? 0,
    );
  }

  factory ErrorModel.fromResponse(Response? response) {
    if (response?.data == null) {
      return ErrorModel(
        name: 'Erro desconhecido',
        message: 'Ocorreu um erro desconhecido, tente novamente mais tarde',
        code: 0,
      );
    }
    switch (response!.statusCode) {
      case 401:
        return ErrorModel(
          name: 'Não autorizado',
          message: 'Sua sessão expirou, faça login novamente',
          code: 0,
        );
      case 403:
        return ErrorModel(
          name: 'Pribido',
          message: 'Você não tem permissão para acessar essa área',
          code: 0,
        );
      case 404:
        return ErrorModel(
          name: 'Não encontrado',
          message: response.data['mensagem'],
          code: 0,
        );
      case 400:
        return ErrorModel(
          name: 'Erro na requisição',
          message: response.data['mensagem'],
          code: 0,
        );
      default:
        return ErrorModel(
          name: 'Erro desconhecido',
          message: 'Ocorreu um erro desconhecido, tente novamente mais tarde',
          code: 0,
        );
    }
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ErrorModel(name: $name, message: $message, code: $code)';
  }
}