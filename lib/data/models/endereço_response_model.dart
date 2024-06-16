import 'dart:convert';

class EnderecoResponseModel{

  final String cep;
  final String state;
  final String city;
  final String neighborhood;
  final String street;
  final String service;

  EnderecoResponseModel({
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.service,
  });

  factory EnderecoResponseModel.fromJson(String source) => EnderecoResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory EnderecoResponseModel.fromMap(Map<String, dynamic> map) {
    return EnderecoResponseModel(
      cep: map['cep'],
      state: map['state'],
      city: map['city'],
      neighborhood: map['neighborhood'],
      street: map['street'],
      service: map['service'],
    );
  }
}