import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
  });
}