import '../data/models/usuario_model.dart';

class AppConstants{

  static late UsuarioModel _usuario;

  static UsuarioModel get usuario => _usuario;

  static void setUser(UsuarioModel usuario) => _usuario = usuario;

}