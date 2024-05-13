import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/data/models/produto_model.dart';

import '../services/firestore_service.dart';

class ProdutosRepository {
  static Future<List<ProdutoModel>> getProdutosFromRestaurante(String restauranteId) async {
    final snapshot = await FirestoreService.firebaseFirestore.collection("produtos").where("restauranteId", isEqualTo: restauranteId).get();
    return snapshot.docs.map((doc) => ProdutoModel.fromSnapshot(doc)).toList();
  }

}
