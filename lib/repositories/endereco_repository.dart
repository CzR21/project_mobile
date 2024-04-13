import 'package:dio/dio.dart';
import '../data/models/endereco_model.dart';

class EnderecoRepository{

  static Future<List<EnderecoModel>> getEnderecos() async {
    try{
      return <EnderecoModel>[
        EnderecoModel(
          longadouro: "Rua das Flores",
          numero: 123,
          complemento: "Apto 101",
          bairro: "Centro",
          cidade: "São Paulo",
          estado: "SP",
          tipoEndereco: TipoEndereco.casa,
        ),

        EnderecoModel(
          longadouro: "Avenida Principal",
          numero: 456,
          bairro: "Jardim Botânico",
          cidade: "Rio de Janeiro",
          estado: "RJ",
          tipoEndereco: TipoEndereco.trabalho,
        ),

        EnderecoModel(
          longadouro: "Rua das Palmeiras",
          numero: 789,
          bairro: "Vila Nova",
          cidade: "Belo Horizonte",
          estado: "MG",
        ),

        EnderecoModel(
          longadouro: "Avenida das Águias",
          numero: 101,
          bairro: "Centro",
          cidade: "Curitiba",
          estado: "PR",
          apelido: "Casa da Vovó",
        ),

        EnderecoModel(
          longadouro: "Rua dos Girassóis",
          numero: 222,
          bairro: "Jardim das Flores",
          cidade: "Brasília",
          estado: "DF",
          tipoEndereco: TipoEndereco.casa,
        ),

        EnderecoModel(
          longadouro: "Rua das Amendoeiras",
          numero: 543,
          complemento: "Bloco C",
          bairro: "Jardim Europa",
          cidade: "Porto Alegre",
          estado: "RS",
        ),

        EnderecoModel(
          longadouro: "Avenida dos Flamboyants",
          numero: 777,
          bairro: "Praia Grande",
          cidade: "Fortaleza",
          estado: "CE",
          tipoEndereco: TipoEndereco.trabalho,
        ),

        EnderecoModel(
          longadouro: "Rua das Acácias",
          numero: 888,
          bairro: "Jardim São Paulo",
          cidade: "Recife",
          estado: "PE",
        ),

        EnderecoModel(
          longadouro: "Avenida das Orquídeas",
          numero: 333,
          complemento: "Fundos",
          bairro: "Centro",
          cidade: "Salvador",
          estado: "BA",
        ),

        EnderecoModel(
          longadouro: "Rua dos Ipês",
          numero: 555,
          bairro: "Jardim das Rosas",
          cidade: "Goiânia",
          estado: "GO",
          tipoEndereco: TipoEndereco.casa,
        ),
    ];
    }on DioException catch (e){
      rethrow;
    }
  }
}
