import 'package:dio/dio.dart';

import '../data/models/restaurante_model.dart';

class RestauranteRepository {
  static Future<List<RestauranteModel>> getPrincipaisRestaurantes() async {
    try {
      return <RestauranteModel>[
        RestauranteModel(
          id: 'fbbbcce0-df7a-4e14-93a0-18b4fd722548',
          nome: "Pizza da Nonna",
          categorias: [Categoria.pizza],
          frete: 5.00,
          tempo: "30 min",
          image: "pizza_da_nonna.jpg",
          nota: 4.5,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: 'a24dd5a1-8fad-4d13-8a6a-3e9e06e8cf54',
          nome: "Burger Express",
          categorias: [Categoria.hamburguer],
          frete: 3.00,
          tempo: "25 min",
          image: "hamburgueria.jpg",
          nota: 4.2,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: 'ec53751b-6517-44d1-b465-934eff65658a',
          nome: "Sushi Palace",
          categorias: [Categoria.japonesa],
          frete: 6.00,
          tempo: "40 min",
          image: "sushi.jpg",
          nota: 4.8,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: '487c0902-4932-49cd-9ca0-51f4fe7b42a5',
          nome: "Falafel House",
          categorias: [Categoria.bebidas],
          frete: 4.50,
          tempo: "35 min",
          image: "lanches.jpg",
          nota: 4.0,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: '453a7d24-3116-4afa-9c6b-d06b85c33ed1',
          nome: "Sabor Brasileiro",
          categorias: [Categoria.brasileira],
          frete: 7.00,
          tempo: "45 min",
          image: "restaurante.jpg",
          nota: 4.6,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: 'a2f40cac-cb99-4049-84fe-473a3d590ded',
          nome: "Pastelaria do João",
          categorias: [Categoria.pastel],
          frete: 4.00,
          tempo: "20 min",
          image: "lanches.jpg",
          nota: 4.3,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: '1d9ba73e-75c6-4b9b-a821-4ac02a286209',
          nome: "Doces Delícias",
          categorias: [Categoria.doces],
          frete: 5.50,
          tempo: "30 min",
          image: "confeitaria.jpg",
          nota: 4.7,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: '29763702-33dc-4318-ac82-73f19b8398eb',
          nome: "Gelateria Gelatto",
          categorias: [Categoria.sorvetes],
          frete: 4.50,
          tempo: "25 min",
          image: "sorveteria.jpg",
          nota: 4.9,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: 'b1fcf79e-f21b-4f7f-9edf-9d87f26d6e2b',
          nome: "Forno da Vovó",
          categorias: [Categoria.pizza],
          frete: 5.00,
          tempo: "30 min",
          image: "pizzaria.jpg",
          nota: 4.4,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
        RestauranteModel(
          id: '1902c775-befa-4913-aeff-af20fea13910',
          nome: "Café Aromático",
          categorias: [Categoria.hamburguer],
          frete: 3.50,
          tempo: "20 min",
          image: "lanches.jpg",
          nota: 4.6,
          descricao:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ipsum purus, venenatis porttitor tincidunt a, ultricies id dui.',
        ),
      ];
    } on DioException {
      rethrow;
    }
  }
}
