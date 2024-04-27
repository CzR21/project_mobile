import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_mobile/data/models/erro_model.dart';

class AutenticacaoRepository{

  static Future<void> login(String email, String senha) async{
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ErrorModel(name: "Usuário não cadastrado", message: "Usuário não cadastrado", code: 400);
      } else if (e.code == 'wrong-password') {
        throw ErrorModel(name: "Senha incorreta", message: "Usuário e/ou senha incorreta", code: 400);
      }
      throw ErrorModel(name: "Erro desconhecido", message: e.code, code: 400);
    }
  }

  static Future<void> cadastro(String email, String senha) async{
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.createUserWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

      } else if (e.code == 'wrong-password') {

      }
    }
  }

  static Future<void> logout() async{
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signOut();
    } on FirebaseAuthException catch (e) {

    }
  }

  static Stream<User?> get usuarioAutenticado{
    final FirebaseAuth auth = FirebaseAuth.instance;

    return auth.authStateChanges();
  }
}