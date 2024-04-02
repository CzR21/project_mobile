import 'package:project_mobile/settings/app_assets.dart';

enum TipoEndereco { casa, trabalho, none }

class EnderecoModel{

  String longadouro;
  int numero;
  String? complemento;
  String bairro;
  String cidade;
  String estado;
  String? apelido;
  TipoEndereco tipoEndereco;

  EnderecoModel({
    required this.longadouro,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.apelido,
    this.tipoEndereco = TipoEndereco.none
  });

  String get image {
    switch(tipoEndereco){
      case TipoEndereco.casa: return AppAssets.homeIcon;
      case TipoEndereco.trabalho: return AppAssets.homeIcon;
      case TipoEndereco.none: return AppAssets.watchIcon;
    }
  }

  @override
  String toString() {
    return '$longadouro, $numero${complemento == null ? '' : ' - $complemento'} - $bairro, $cidade, - $estado';
  }
}