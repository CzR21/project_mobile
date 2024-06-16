import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/data/models/endereco_model.dart';
import 'package:project_mobile/data/models/usuario_model.dart';

class FirestoreService{

  static final FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

  static FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  static Future<UsuarioModel?> buscarUsuarioPorEmail(String email) async {
    var user = await FirestoreService.firebaseFirestore.collection("usuarios").where('email', isEqualTo: email).get();

    return user.docs.isEmpty ? null : UsuarioModel.fromMap(user.docs.first.data());
  }

  static Future<List<EnderecoModel>> buscarEnderecos(String idUsuario) async {
    var user = await FirestoreService.firebaseFirestore.collection("enderecos").where('idUsuario', isEqualTo: idUsuario).get();

    return user.docs.map((e) => EnderecoModel.fromMap(e.data())).toList();
  }

  static Future<void> adicionarEndereco(EnderecoModel endereco) async {
    await firebaseFirestore.collection("enderecos").add(endereco.toMap());
  }
}