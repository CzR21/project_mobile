import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/data/models/produto_model.dart';
import 'package:project_mobile/database/db_firestore.dart';

class ProdutosRepository {
  static Future<List<ProdutoModel>> getProdutosFromRestaurante(String restauranteId) async {
    FirebaseFirestore db = DBFirestore.get();
    final snapshot = await db.collection("produtos").where("restauranteId", isEqualTo: restauranteId).get();
    return snapshot.docs.map((doc) => ProdutoModel.fromSnapshot(doc)).toList();
  }

}
