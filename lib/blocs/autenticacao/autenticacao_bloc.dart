import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/blocs/autenticacao/autenticacao_state.dart';
import 'package:project_mobile/data/models/usuario_model.dart';
import 'package:project_mobile/repositories/autenticacao_repository.dart';

import '../../data/models/erro_model.dart';

part 'autenticacao_event.dart';


class AutenticacaoBloc extends Bloc<AutenticacaoEvent, AutenticacaoState> {

  AutenticacaoBloc() : super(AutenticacaoInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        await AutenticacaoRepository.login(event.email, event.senha);
        emit(SuccessLoginState());
      } on ErrorModel catch (e) {
        emit(ErrorLoginState(erro: e));
      }
    });

    on<CadastroEvent>((event, emit) async {
      try {
        await AutenticacaoRepository.cadastro(event.model, event.senha, event.imagem);
        emit(SuccessCadastroState());
      } on ErrorModel catch (e) {
        emit(ErrorCadastroState(erro: e));
      }
    });
  }
}
