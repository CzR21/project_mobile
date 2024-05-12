// ignore_for_file: must_be_immutable

part of 'produto_bloc.dart';

@immutable
abstract class ProdutoEvent {}

class GetProdutoEvent extends ProdutoEvent {
  String restauranteId;

  GetProdutoEvent({
    required this.restauranteId,
  });
}
