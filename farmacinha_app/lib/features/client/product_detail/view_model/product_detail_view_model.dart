import 'package:flutter/material.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:farmacia_app/features/client/home_client/data/models/product_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final AuthSessionViewModel _authSession;
  final Product product;
  bool _isAdding = false;

  ProductDetailViewModel({
    required this.product,
    AuthSessionViewModel? authSession,
  }) : _authSession = authSession ?? AuthSessionViewModel.instance;

  bool get isAdding => _isAdding;

  // Lógica para adicionar ao carrinho com feedback visual
  Future<void> addToCart(BuildContext context) async {
    if (!_authSession.requireAuthentication(
      context,
      message: 'Entre com sua conta para adicionar este produto ao carrinho.',
    )) {
      return;
    }

    if (_isAdding) return; // Evita cliques duplos enquanto processa

    _isAdding = true;
    notifyListeners();

    // Simula uma pequena espera (delay) como se estivesse enviando para uma API
    await Future.delayed(const Duration(milliseconds: 500));
    
    debugPrint('Produto ${product.name} enviado para o carrinho!');
    
    _isAdding = false;
    notifyListeners();
  }

  void buyNow(BuildContext context) {
    if (!_authSession.requireAuthentication(
      context,
      message: 'Entre com sua conta para comprar este produto.',
    )) {
      return;
    }

    debugPrint("Comprando: ${product.name}");
  }
}
