import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/erro_model.dart';
import '../../repositories/endereco_repository.dart';
import 'endereco_state.dart';

part 'endereco_event.dart';


class EnderecoBloc extends Bloc<EnderecoEvent, EnderecoState> {

  EnderecoBloc() : super(EnderecoInitial()) {
    on<GetEnderecosEvent>((event, emit) async {
      try {
        emit(SuccessGetEnderecosState(model: await EnderecoRepository.getEnderecos()));
      } on ErrorModel catch (e) {
        emit(ErrorGetEnderecosState(erro: e));
      }
    });
  }
}
