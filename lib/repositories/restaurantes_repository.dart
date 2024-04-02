import 'package:dio/dio.dart';

import '../data/models/restaurante_model.dart';

class RestauranteRepository{

  static Future<List<RestauranteModel>> getPirncipaisRestaurantes() async {
    try{
      return <RestauranteModel>[
        RestauranteModel(
          id: 'fbbbcce0-df7a-4e14-93a0-18b4fd722548',
          nome: "Pizza da Nonna",
          categorias: [Categoria.Pizza],
          frete: 5.00,
          tempo: "30 min",
          image: "pizza_da_nonna.jpg",
          nota: 4.5,
        ),
        RestauranteModel(
          id: 'a24dd5a1-8fad-4d13-8a6a-3e9e06e8cf54',
          nome: "Burger Express",
          categorias: [Categoria.Lanche],
          frete: 3.00,
          tempo: "25 min",
          image: "burger_express.jpg",
          nota: 4.2,
        ),
        RestauranteModel(
          id: 'ec53751b-6517-44d1-b465-934eff65658a',
          nome: "Sushi Palace",
          categorias: [Categoria.Japonesa],
          frete: 6.00,
          tempo: "40 min",
          image: "sushi_palace.jpg",
          nota: 4.8,
        ),
        RestauranteModel(
          id: '487c0902-4932-49cd-9ca0-51f4fe7b42a5',
          nome: "Falafel House",
          categorias: [Categoria.Arabe],
          frete: 4.50,
          tempo: "35 min",
          image: "falafel_house.jpg",
          nota: 4.0,
        ),
        RestauranteModel(
          id: '453a7d24-3116-4afa-9c6b-d06b85c33ed1',
          nome: "Sabor Brasileiro",
          categorias: [Categoria.Brasileira],
          frete: 7.00,
          tempo: "45 min",
          image: "sabor_brasileiro.jpg",
          nota: 4.6,
        ),
        RestauranteModel(
          id: 'a2f40cac-cb99-4049-84fe-473a3d590ded',
          nome: "Pastelaria do João",
          categorias: [Categoria.Pastel],
          frete: 4.00,
          tempo: "20 min",
          image: "pastelaria_do_joao.jpg",
          nota: 4.3,
        ),
        RestauranteModel(
          id: '1d9ba73e-75c6-4b9b-a821-4ac02a286209',
          nome: "Doces Delícias",
          categorias: [Categoria.Doces],
          frete: 5.50,
          tempo: "30 min",
          image: "doces_delicias.jpg",
          nota: 4.7,
        ),
        RestauranteModel(
          id: '29763702-33dc-4318-ac82-73f19b8398eb',
          nome: "Gelateria Gelatto",
          categorias: [Categoria.Sorvete],
          frete: 4.50,
          tempo: "25 min",
          image: "gelateria_gelatto.jpg",
          nota: 4.9,
        ),
        RestauranteModel(
          id: 'b1fcf79e-f21b-4f7f-9edf-9d87f26d6e2b',
          nome: "Forno da Vovó",
          categorias: [Categoria.Pizza],
          frete: 5.00,
          tempo: "30 min",
          image: "forno_da_vovo.jpg",
          nota: 4.4,
        ),
        RestauranteModel(
          id: '1902c775-befa-4913-aeff-af20fea13910',
          nome: "Café Aromático",
          categorias: [Categoria.Lanche],
          frete: 3.50,
          tempo: "20 min",
          image: "cafe_aromatico.jpg",
          nota: 4.6,
        ),
      ];
    }on DioException catch (e){
      rethrow;
    }
  }

}
