import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/erro_model.dart';

@immutable
abstract class AutenticacaoState {}

class AutenticacaoInitial extends AutenticacaoState {}

class SuccessLoginState extends AutenticacaoState {}

class ErrorLoginState extends AutenticacaoState {

  final ErrorModel erro;

  ErrorLoginState({
    required this.erro,
  });
}

class SuccessCadastroState extends AutenticacaoState {}

class ErrorCadastroState extends AutenticacaoState {

  final ErrorModel erro;

  ErrorCadastroState({
    required this.erro,
  });
}

