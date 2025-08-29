import 'package:flutter/material.dart';

class ImageModel{
  final String name;
  final String price;
  final String imagePath;
  final String description;

  ImageModel({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
  });
}
