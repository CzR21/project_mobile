import 'package:flutter/material.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import 'restaurante_model.dart';

class CategoriaModel{

  Categoria categoria;
  bool select;

  CategoriaModel(this.categoria, { this.select = false,});

  String get nome{
    switch(categoria){
      case Categoria.pizza: return "Pizza";
      case Categoria.hamburguer: return "Lanches";
      case Categoria.japonesa: return "Japonesa";
      case Categoria.brasileira: return "Brasileira";
      case Categoria.bebidas: return "Bebidas";
      case Categoria.doces: return "Doces";
      case Categoria.sorvetes: return "Sorvetes";
      default: return "";
    }
  }

  String get image{
    switch(categoria){
      case Categoria.pizza: return AppAssets.pizzaImage;
      case Categoria.hamburguer: return AppAssets.hamburguerImage;
      case Categoria.japonesa: return AppAssets.japonesaImage;
      case Categoria.brasileira: return AppAssets.brasileiraImage;
      case Categoria.bebidas: return AppAssets.bebidasImage;
      case Categoria.doces: return AppAssets.boloImage;
      case Categoria.sorvetes: return AppAssets.sorveteImage;
      default: return "";
    }
  }

  Color get backgroundColor{
    switch(categoria){
      case Categoria.pizza: return AppColors.liteYellowColor;
      case Categoria.hamburguer: return AppColors.liteOrangeColor;
      case Categoria.japonesa: return AppColors.liteReColor ;
      case Categoria.brasileira: return AppColors.liteGreenColor;
      case Categoria.bebidas: return AppColors.liteLiteBlueColor;
      case Categoria.doces: return AppColors.liteBlueColor;
      case Categoria.sorvetes: return AppColors.litePurpleColor;
      default: return AppColors.backgroundColor;
    }
  }
}