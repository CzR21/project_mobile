import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/data/models/usuario_model.dart';

import '../helpers/toasty_helper.dart';

class FirestoreService{

  static final FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

  static FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  static Future<UsuarioModel?> buscarUsuarioPorEmail(String email) async {
    var user = await FirestoreService.firebaseFirestore.collection("usuarios").where('email', isEqualTo: email).get();

    return user.docs.isEmpty ? null : UsuarioModel.fromMap(user.docs.first.data());
  }

}