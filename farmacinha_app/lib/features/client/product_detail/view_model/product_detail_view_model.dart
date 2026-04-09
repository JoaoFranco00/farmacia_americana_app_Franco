import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/home_client/data/models/product_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final Product product;
  bool _isAdding = false;

  ProductDetailViewModel({required this.product});

  bool get isAdding => _isAdding;

  // Lógica para adicionar ao carrinho com feedback visual
  Future<void> addToCart() async {
    if (_isAdding) return; // Evita cliques duplos enquanto processa

    _isAdding = true;
    notifyListeners();

    // Simula uma pequena espera (delay) como se estivesse enviando para uma API
    await Future.delayed(const Duration(milliseconds: 500));
    
    debugPrint('Produto ${product.name} enviado para o carrinho!');
    
    _isAdding = false;
    notifyListeners();
  }
}