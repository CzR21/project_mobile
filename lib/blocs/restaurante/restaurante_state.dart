import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/erro_model.dart';

import '../../data/models/restaurante_model.dart';

@immutable
abstract class RestauranteState {}

class RestauranteInitial extends RestauranteState {}

class SuccessGetPrincipaisRestaurantesState extends RestauranteState {

  final List<RestauranteModel> model;

  SuccessGetPrincipaisRestaurantesState({
    required this.model,
  });
}

class ErrorGetPrincipaisRestaurantesState extends RestauranteState {

  final ErrorModel erro;

  ErrorGetPrincipaisRestaurantesState({
    required this.erro,
  });
}

