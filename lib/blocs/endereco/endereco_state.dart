import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/endere%C3%A7o_response_model.dart';
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

class SuccessGetEnderecosPeloCepState extends EnderecoState {

  final EnderecoResponseModel model;

  SuccessGetEnderecosPeloCepState({
    required this.model,
  });
}

class ErrorGetEnderecosPeloCepState extends EnderecoState {

  final ErrorModel erro;

  ErrorGetEnderecosPeloCepState({
    required this.erro,
  });
}


