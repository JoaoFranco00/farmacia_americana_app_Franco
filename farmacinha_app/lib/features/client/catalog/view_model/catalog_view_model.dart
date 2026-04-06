import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/catalog/data/mock_products.dart';
import 'package:farmacia_app/features/client/catalog/data/mock_categories.dart';

// Modelo simplificado de Produto
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isOnPromotion;
  final int? discountPercentage;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isOnPromotion = false,
    this.discountPercentage,
  });
}

// Modelo de Categoria
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

class CatalogViewModel extends ChangeNotifier {
  // ===== DADOS PRIVADOS =====
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Category> _categories = [];

  String _selectedCategoryId = '';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController searchController = TextEditingController();

  // ===== GETTERS =====
  List<Product> get filteredProducts => _filteredProducts;
  List<Category> get categories => _categories;
  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ===== CONSTRUTOR =====
  CatalogViewModel() {
    _initializeCatalog();
    searchController.addListener(_onSearchChanged);
  }

  // ===== MÉTODOS PRIVADOS =====

  /// Inicializa o catálogo com dados mockados
  void _initializeCatalog() {
    _setLoading(true);
    _errorMessage = null;

    // Simular latência de rede
    Future.delayed(const Duration(milliseconds: 800), () {
      _allProducts = MockProducts.getProducts();
      _categories = MockCategories.getCategories();
      _filteredProducts = _allProducts;
      _setLoading(false);
      notifyListeners();
    });
  }

  /// Atualiza a query de busca
  void _onSearchChanged() {
    _searchQuery = searchController.text;
    _applyFilters();
  }

  /// Aplica os filtros (categoria + busca)
  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      // Filtro de categoria
      final categoryMatch = _selectedCategoryId.isEmpty ||
          _selectedCategoryId == 'all' ||
          product.category == _selectedCategoryId;

      // Filtro de busca
      final searchMatch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  // ===== MÉTODOS PÚBLICOS =====

  /// Seleciona uma categoria
  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    _applyFilters();
  }

  /// Limpa a busca e os filtros
  void clearFilters() {
    searchController.clear();
    _selectedCategoryId = '';
    _searchQuery = '';
    _applyFilters();
  }

  /// Adiciona um produto ao carrinho (callback)
  void addToCart(Product product) {
    debugPrint(
        'Produto adicionado ao carrinho: ${product.name} - ID: ${product.id}');
    // Implementar lógica de carrinho
  }

  /// Navega para detalhes do produto (callback)
  void viewProductDetail(Product product) {
    debugPrint(
        'Abrindo detalhes do produto: ${product.name} - ID: ${product.id}');
    // Navegar para product_detail_screen
  }

  /// Retorna promoções em destaque
  List<Product> getPromotionalProducts() {
    return _allProducts.where((p) => p.isOnPromotion).toList().take(5).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
