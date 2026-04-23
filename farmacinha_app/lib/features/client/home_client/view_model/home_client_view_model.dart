import 'package:flutter/material.dart';
import 'package:farmacia_app/features/client/home_client/data/mocks/mock_products.dart';
import 'package:farmacia_app/features/client/home_client/data/mocks/mock_categories.dart';
import 'package:farmacia_app/features/client/home_client/data/models/banner_model.dart';
import 'package:farmacia_app/features/client/home_client/data/mocks/mock_banners.dart';
import 'package:farmacia_app/features/client/home_client/data/models/product_model.dart';
import 'package:farmacia_app/features/client/home_client/data/models/category_model.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';

class HomeClientViewModel extends ChangeNotifier {
  final AuthSessionViewModel _authSession;

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
  List<BannerModel> get banners => _banners;
  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isGuest => _authSession.isGuest || !_authSession.isAuthenticated;

  // ===== CONSTRUTOR =====
  HomeClientViewModel({AuthSessionViewModel? authSession})
      : _authSession = authSession ?? AuthSessionViewModel.instance {
    _initializeHome();
    searchController.addListener(_onSearchChanged);
  }

  // ===== MÉTODOS PRIVADOS =====

  void _initializeHome() {
    _setLoading(true);
    _errorMessage = null;

    // Simula o tempo de resposta de uma API
    Future.delayed(const Duration(milliseconds: 800), () {
      try {
        _allProducts = MockProducts.getProducts();
        _categories = MockCategories.getCategories();
        _banners = MockBanners.getBanners();
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
          product.category.toLowerCase() == _selectedCategoryId.toLowerCase();

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

  void addToCart(BuildContext context, Product product) {
    if (!_authSession.requireAuthentication(
      context,
      message: 'Entre com sua conta para adicionar produtos ao carrinho.',
    )) {
      return;
    }

    // Aqui você conectará futuramente com a sua CartViewModel ou Service
    debugPrint('Adicionado ao carrinho: ${product.name}');
  }

  bool requestProtectedAction(BuildContext context, String message) {
    return _authSession.requireAuthentication(context, message: message);
  }

  // Este método pode ser usado para Analytics ou logs antes da navegação
  void viewProductDetail(Product product) {
    debugPrint('Usuário visualizando detalhes de: ${product.name}');
  }

  List<Product> getPromotionalProducts() {
    return _allProducts.where((p) => p.isOnPromotion).toList().take(5).toList();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
}
