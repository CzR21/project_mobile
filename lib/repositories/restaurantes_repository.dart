import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/restaurante_model.dart';
import '../services/firestore_service.dart';

class RestauranteRepository {

  static Future<List<RestauranteModel>> getPrincipaisRestaurantes() async {
    final snapshot = await FirestoreService.firebaseFirestore.collection("restaurantes").get();
    return snapshot.docs.map((doc) => RestauranteModel.fromSnapshot(doc)).toList();
  }
}
