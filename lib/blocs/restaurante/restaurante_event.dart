part of 'restaurante_bloc.dart';

@immutable
abstract class RestauranteEvent {}

// ignore: must_be_immutable
class GetPrincipaisRestaurantesEvent extends RestauranteEvent {

  String? search;
  List<Categoria>? categorias;

  GetPrincipaisRestaurantesEvent({
    this.search,
    this.categorias,
  });
}