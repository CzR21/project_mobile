import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_mobile/data/models/erro_model.dart';
import 'package:project_mobile/data/models/usuario_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../config/app_routes.dart';
import '../services/firestore_service.dart';

class AutenticacaoRepository {
  static Future<void> login(String email, String senha) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ErrorModel(
            name: "Usuário não cadastrado",
            message: "Usuário não cadastrado",
            code: 400);
      } else if (e.code == 'wrong-password') {
        throw ErrorModel(
            name: "Senha incorreta",
            message: "Usuário e/ou senha incorreta",
            code: 400);
      }
      throw ErrorModel(name: "Erro desconhecido", message: e.code, code: 400);
    }
  }

  static Future<void> cadastro(
      UsuarioModel model, String senha, String imagem) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: model.email, password: senha);

      String imageUrl = '';
      if (imagem != "") {
        imageUrl = await uploadImage(imagem, userCredential.user!.uid);
      }

      await FirestoreService.firebaseFirestore
          .collection("usuarios")
          .doc(userCredential.user!.uid)
          .set({
        ...model.toMap(),
        if (imageUrl.isNotEmpty) 'imagemUrl': imageUrl,
      });
    } on FirebaseAuthException catch (e) {
      throw ErrorModel(
          name: e.message ?? "Erro desconhecido", message: e.code, code: 400);
    }
  }

  static Future<String> uploadImage(String file, String userId) async {
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(userId + '.jpg');
    UploadTask uploadTask = ref.putFile(File(file));
    final TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  static Future<void> logout() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signOut();
      print('aqui');
      Navigator.of(AppRoutes.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw ErrorModel(
          name: e.message ?? "Erro desconhecido", message: e.code, code: 400);
    }
  }

  static Stream<User?> get usuarioAutenticado {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return auth.authStateChanges();
  }
}
