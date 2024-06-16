import 'package:dio/dio.dart';
import 'package:project_mobile/config/app_api.dart';
import 'package:project_mobile/config/app_contansts.dart';
import 'package:project_mobile/data/models/endere%C3%A7o_response_model.dart';
import 'package:project_mobile/data/models/erro_model.dart';
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

  static Future<EnderecoResponseModel> getEnderecoPeloCep(String cep) async {
    try{
      var result = await AppAPI.get(AppAPI.buscarCep + cep);
      return EnderecoResponseModel.fromMap(result.data);
    }on DioException catch (e){
      throw ErrorModel.fromResponse(e.response);
    }
  }
}
