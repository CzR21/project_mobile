import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/database/db_firestore.dart';

import '../data/models/restaurante_model.dart';

class RestauranteRepository {

  static Future<List<RestauranteModel>> getPrincipaisRestaurantes() async {
    FirebaseFirestore db = DBFirestore.get();
    final snapshot = await db.collection("restaurantes").get();
    return snapshot.docs.map((doc) => RestauranteModel.fromSnapshot(doc)).toList();
  }
}
