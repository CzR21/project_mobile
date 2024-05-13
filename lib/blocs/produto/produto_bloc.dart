import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_mobile/data/models/erro_model.dart';
import 'package:project_mobile/data/models/produto_model.dart';
import 'package:project_mobile/repositories/produtos_repository.dart';

part 'produto_event.dart';
part 'produto_state.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  ProdutoBloc() : super(ProdutoInitial()) {
    on<GetProdutoEvent>((event, emit) async {
      try {
        final produtos = await ProdutosRepository.getProdutosFromRestaurante(
            event.restauranteId);
        if (produtos.isEmpty) {
          emit(ErrorGetProdutosState(
            erro: ErrorModel(
                message: "Não possui produto", name: "NotFound", code: 400),
          ));
        }
        Map<String, List<ProdutoModel>> produtosCategoria = {};

        for (var produto in produtos) {
          produtosCategoria
              .putIfAbsent(produto.categoria.name, () => [])
              .add(produto);
        }

        emit(SuccessGetProdutosState(model: produtosCategoria));
      } on ErrorModel catch (e) {
        emit(ErrorGetProdutosState(erro: e));
      }
    });
  }
}
