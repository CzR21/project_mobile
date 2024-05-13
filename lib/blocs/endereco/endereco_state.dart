import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/erro_model.dart';

import '../../data/models/endereco_model.dart';

@immutable
abstract class EnderecoState {}

class EnderecoInitial extends EnderecoState {}

class SuccessGetEnderecosState extends EnderecoState {

  final List<EnderecoModel> model;

  SuccessGetEnderecosState({
    required this.model,
  });
}

class ErrorGetEnderecosState extends EnderecoState {

  final ErrorModel erro;

  ErrorGetEnderecosState({
    required this.erro,
  });
}

