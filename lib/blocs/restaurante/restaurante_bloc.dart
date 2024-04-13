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
        var restaurantes = await RestauranteRepository.getPrincipaisRestaurantes();

        if(event.search != null && event.search!.isNotEmpty){
          restaurantes = restaurantes.where((e) => e.nome.toLowerCase().contains(event.search!.toLowerCase()),).toList();
        }

        emit(SuccessGetPrincipaisRestaurantesState(model: restaurantes));
      } on ErrorModel catch (e) {
        emit(ErrorGetPrincipaisRestaurantesState(erro: e));
      }
    });
  }
}
