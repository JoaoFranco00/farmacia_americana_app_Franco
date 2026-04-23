import 'package:flutter/material.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:farmacia_app/features/client/cart/view_model/cart_view_model.dart';
import 'package:farmacia_app/features/client/home_client/data/models/product_model.dart';
import 'package:farmacia_app/features/client/home_client/data/mocks/mock_products.dart';

class SearchResultViewModel extends ChangeNotifier {
  final AuthSessionViewModel _authSession;
  List<Product> filteredProducts = [];
  List<Product> similarProducts = [];
  String searchQuery = "";
  bool isLoading = false;

  // Construtor com inicialização automática 
  SearchResultViewModel({
    String? initialQuery,
    AuthSessionViewModel? authSession,
  }) : _authSession = authSession ?? AuthSessionViewModel.instance {
    if (initialQuery != null && initialQuery.isNotEmpty) {
      search(initialQuery);
    }
  }

  void search(String query) {
    isLoading = true;
    searchQuery = query;
    notifyListeners();

    // Obtendo a fonte de dados (Mock)
    final allProducts = MockProducts.getProducts();

    // 1. Filtro Inteligente: Busca por nome OU por categoria exata
    filteredProducts = allProducts.where((p) {
      final matchesName = p.name.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = p.category.toLowerCase() == query.toLowerCase();
      return matchesName || matchesCategory;
    }).toList();

    // 2. Busca itens semelhantes (Recomendações)
    if (filteredProducts.isNotEmpty) {
      // Pega a categoria do primeiro item encontrado para sugerir outros da mesma área
      String category = filteredProducts.first.category;
      
      similarProducts = allProducts.where((p) => 
        p.category == category && 
        !filteredProducts.any((fp) => fp.id == p.id)
      ).toList();
    } else {
      similarProducts = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void addToCart(BuildContext context, Product product) {
    if (!_authSession.requireAuthentication(
      context,
      message: 'Entre com sua conta para adicionar produtos ao carrinho.',
    )) {
      return;
    }

    CartViewModel.instance.addProduct(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${product.name} adicionado ao carrinho.')),
      );
  }
}
