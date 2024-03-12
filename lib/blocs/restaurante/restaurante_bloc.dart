import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/repositories/restaurantes_repository.dart';
import '../../data/models/erro_model.dart';
import 'restaurante_state.dart';

part 'restaurante_event.dart';


class RestauranteBloc extends Bloc<RestauranteEvent, RestauranteState> {

  RestauranteBloc() : super(RestauranteInitial()) {
    on<GetPrincipaisRestaurantesEvent>((event, emit) async {
      try {
        emit(SuccessGetPrincipaisRestaurantesState(model: await RestauranteRepository.getPirncipaisRestaurantes()));
      } on ErrorModel catch (e) {
        emit(ErrorGetPrincipaisRestaurantesState(erro: e));
      }
    });
  }
}
