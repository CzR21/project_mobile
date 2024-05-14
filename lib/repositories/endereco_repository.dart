import 'package:dio/dio.dart';
import 'package:project_mobile/config/app_contansts.dart';
import 'package:project_mobile/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

import '../data/models/endereco_model.dart';

class EnderecoRepository{

  static Future<List<EnderecoModel>> getEnderecos() async {
    try{
      return await FirestoreService.buscarEnderecos(AppConstants.usuario.id);
    }on DioException catch (e){
      rethrow;
    }
  }
}
