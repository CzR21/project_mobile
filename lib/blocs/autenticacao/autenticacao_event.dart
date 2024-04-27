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

  final String email;
  final String senha;

  CadastroEvent({
    required this.email,
    required this.senha
  });
}