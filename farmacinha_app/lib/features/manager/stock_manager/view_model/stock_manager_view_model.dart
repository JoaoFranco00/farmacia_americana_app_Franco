// view_model/stock_manager_view_model.dart
//
// Contém os dados e a lógica da tela de Estoque.
// Futuramente os produtos virão de uma API ou banco de dados.

class StockManagerViewModel {
  // Limite para considerar estoque baixo
  static const int lowStockThreshold = 10;

  // Lista de produtos mockados
  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'Dipirona 500mg',
      'category': 'Medicamento',
      'quantity': 120,
      'price': 8.90,
    },
    {
      'name': 'Shampoo Anticaspa',
      'category': 'Higiene',
      'quantity': 45,
      'price': 22.50,
    },
    {
      'name': 'Paracetamol 750mg',
      'category': 'Medicamento',
      'quantity': 3,
      'price': 12.00,
    },
    {
      'name': 'Vitamina C 1g',
      'category': 'Vitaminas',
      'quantity': 80,
      'price': 34.90,
    },
    {
      'name': 'Protetor Solar FPS50',
      'category': 'Higiene',
      'quantity': 18,
      'price': 45.00,
    },
    {
      'name': 'Omeprazol 20mg',
      'category': 'Medicamento',
      'quantity': 7,
      'price': 19.90,
    },
    {
      'name': 'Vitamina D 2000UI',
      'category': 'Vitaminas',
      'quantity': 55,
      'price': 28.00,
    },
    {
      'name': 'Sabonete Líquido',
      'category': 'Higiene',
      'quantity': 60,
      'price': 14.90,
    },
    {
      'name': 'Ibuprofeno 600mg',
      'category': 'Medicamento',
      'quantity': 9,
      'price': 16.50,
    },
    {
      'name': 'Complexo B',
      'category': 'Vitaminas',
      'quantity': 40,
      'price': 22.00,
    },
  ];

  // Categorias disponíveis para filtro
  final List<String> categories = [
    'Todos',
    'Medicamento',
    'Higiene',
    'Vitaminas',
  ];

  // Retorna os produtos filtrados por categoria e busca
  List<Map<String, dynamic>> getFilteredProducts({
    required String selectedCategory,
    required String searchQuery,
  }) {
    return _allProducts.where((product) {
      // Filtro de categoria
      final matchesCategory = selectedCategory == 'Todos' ||
          product['category'] == selectedCategory;

      // Filtro de busca pelo nome
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Verifica se o produto está com estoque baixo
  bool isLowStock(int quantity) => quantity <= lowStockThreshold;

  // Total de produtos cadastrados
  int get totalProducts => _allProducts.length;
}