part of 'produto_bloc.dart';

@immutable
class ProdutoState {}

class ProdutoInitial extends ProdutoState {}

class SuccessGetProdutosState extends ProdutoState {

  final Map<String, List<ProdutoModel>> model;

  SuccessGetProdutosState({
    required this.model,
  });
}

class ErrorGetProdutosState extends ProdutoState {

  final ErrorModel erro;

  ErrorGetProdutosState({
    required this.erro,
  });
}

