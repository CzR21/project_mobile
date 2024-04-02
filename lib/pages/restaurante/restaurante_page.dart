import "package:flutter/material.dart";
import "package:project_mobile/data/models/restaurante_model.dart";

class RestaurantePage extends StatefulWidget {
  final RestauranteModel restaurante;
  const RestaurantePage({ super.key, required this.restaurante});

  @override
  _RestaurantePageState createState() => _RestaurantePageState();
}

class _RestaurantePageState extends State<RestaurantePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurante.nome),
      ),
    );
  }
}