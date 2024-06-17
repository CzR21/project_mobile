part of 'autenticacao_bloc.dart';

@immutable
abstract class AutenticacaoEvent {}

class LoginEvent extends AutenticacaoEvent {

  final String email;
  final String senha;

  LoginEvent({
    required this.email,
    required this.senha
  });
}

class CadastroEvent extends AutenticacaoEvent {

  final UsuarioModel model;
  final String senha;
  final String imagem;

  CadastroEvent({
    required this.model,
    required this.senha,
    required this.imagem,
  });
}