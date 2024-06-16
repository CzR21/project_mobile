part of 'endereco_bloc.dart';

@immutable
abstract class EnderecoEvent {}

class GetEnderecosEvent extends EnderecoEvent {}

class GetEnderecosPeloCepEvent extends EnderecoEvent {

  String cep;

  GetEnderecosPeloCepEvent({
    required this.cep
  });
}