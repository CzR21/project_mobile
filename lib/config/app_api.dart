import 'package:dio/dio.dart';

class AppAPI {

  // Padrão para as requisições
  static Dio get _dio => Dio(
    BaseOptions(
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  );

  // Caminhos da API
  static const String buscarCep = 'https://brasilapi.com.br/api/cep/v2/';

  // Verbos para as requisições
  static Future<Response> get(String path, { Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, }) async {
    final dio = _dio;

    return await dio.get(path, data: data, queryParameters: queryParameters,);
  }

  static Future<Response> post(String path, { Map<String, dynamic>? queryParameters, Object? data, String? webToken}) async {
    final dio = _dio;

    return await dio.post(webToken == null ? path : path, data: data, queryParameters: queryParameters,);
  }

  static Future<Response> put(String path, { Map<String, dynamic>? queryParameters, Object? data,}) async {
    final dio = _dio;

    return await dio.put(path, data: data, queryParameters: queryParameters,);
  }

  static Future<Response> delete(String path, { Map<String, dynamic>? queryParameters, Object? data,}) async {
    final dio = _dio;

    return await dio.delete(path, data: data, queryParameters: queryParameters,);
  }
}