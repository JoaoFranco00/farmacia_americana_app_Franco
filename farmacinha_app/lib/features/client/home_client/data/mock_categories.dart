import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/home_client/data/category_model.dart';
import 'package:farmacia_app/features/client/home_client/data/mock_products.dart';


class MockCategories {
  static List<Category> getCategories() {
    final products = MockProducts.getProducts();
    final categoryMap = <String, int>{};

    // Contar produtos por categoria
    for (var product in products) {
      categoryMap[product.category] = (categoryMap[product.category] ?? 0) + 1;
    }

    return [
      Category(
        id: 'all',
        name: 'Todos',
        icon: Icons.apps_rounded,
        productCount: products.length,
      ),
      Category(
        id: 'medicamentos',
        name: 'Medicamentos',
        icon: Icons.healing_rounded,
        productCount: categoryMap['medicamentos'] ?? 0,
      ),
      Category(
        id: 'higiene',
        name: 'Higiene',
        icon: Icons.soap_rounded,
        productCount: categoryMap['higiene'] ?? 0,
      ),
      Category(
        id: 'beleza',
        name: 'Beleza',
        icon: Icons.spa_rounded,
        productCount: categoryMap['beleza'] ?? 0,
      ),
      Category(
        id: 'suplementos',
        name: 'Suplementos',
        icon: Icons.favorite_rounded,
        productCount: categoryMap['suplementos'] ?? 0,
      ),
      Category(
        id: 'vitaminas',
        name: 'Vitaminas',
        icon: Icons.energy_savings_leaf_rounded,
        productCount: categoryMap['vitaminas'] ?? 0,
      ),
    ];
  }
}
