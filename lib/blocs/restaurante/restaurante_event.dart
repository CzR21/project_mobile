part of 'restaurante_bloc.dart';

@immutable
abstract class RestauranteEvent {}

class GetPrincipaisRestaurantesEvent extends RestauranteEvent {

  String? search;

  GetPrincipaisRestaurantesEvent({
    this.search
  });
}