import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/home_client/data/mock_products.dart';
import 'package:farmacia_app/features/client/home_client/data/mock_categories.dart';
import 'package:farmacia_app/features/client/home_client/data/banner_model.dart';
import 'package:farmacia_app/features/client/home_client/data/mock_banners.dart';
import 'package:farmacia_app/features/client/home_client/data/product_model.dart';
import 'package:farmacia_app/features/client/home_client/data/category_model.dart';

class HomeClientViewModel extends ChangeNotifier {
  // ===== DADOS PRIVADOS =====
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Category> _categories = [];
  List<BannerModel> _banners = [];
  
  String _selectedCategoryId = '';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController searchController = TextEditingController();

  // ===== GETTERS =====
  List<Product> get filteredProducts => _filteredProducts;
  List<Category> get categories => _categories;
  List<BannerModel> get banners => _banners; // Getter adicionado
  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ===== CONSTRUTOR =====
  HomeClientViewModel() {
    _initializeHome();
    searchController.addListener(_onSearchChanged);
  }

  // ===== MÉTODOS PRIVADOS =====

  void _initializeHome() {
    _setLoading(true);
    _errorMessage = null;

    Future.delayed(const Duration(milliseconds: 800), () {
      try {
        _allProducts = MockProducts.getProducts();
        _categories = MockCategories.getCategories();
        _banners = MockBanners.getBanners(); // Inicialização adicionada
        _filteredProducts = _allProducts;
        _setLoading(false);
      } catch (e) {
        _errorMessage = "Erro ao carregar dados da farmácia.";
        _setLoading(false);
      }
    });
  }

  void _onSearchChanged() {
    _searchQuery = searchController.text;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final categoryMatch =
          _selectedCategoryId.isEmpty ||
          _selectedCategoryId == 'all' ||
          product.category == _selectedCategoryId;

      final searchMatch =
          _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ===== MÉTODOS PÚBLICOS =====

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    _applyFilters();
  }

  void clearFilters() {
    searchController.clear();
    _selectedCategoryId = '';
    _searchQuery = '';
    _applyFilters();
  }

  void addToCart(Product product) {
    debugPrint('Adicionado ao carrinho: ${product.name}');
  }

  void viewProductDetail(Product product) {
    debugPrint('Ver detalhes: ${product.name}');
  }

  List<Product> getPromotionalProducts() {
    return _allProducts.where((p) => p.isOnPromotion).toList().take(5).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}