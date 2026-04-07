import 'package:farmacia_app/features/client/home_client/data/product_model.dart';

class MockProducts {
  static List<Product> getProducts() {
    return [
      // Medicamentos
      Product(
        id: '1',
        name: 'Dipirona 500mg',
        price: 15.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 324,
        category: 'medicamentos',
        isOnPromotion: true,
        discountPercentage: 20,
      ),
      Product(
        id: '2',
        name: 'Vitamina C 1000mg',
        price: 45.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.6,
        reviewCount: 256,
        category: 'vitaminas',
        isOnPromotion: true,
        discountPercentage: 15,
      ),
      Product(
        id: '3',
        name: 'Omeprazol 20mg',
        price: 28.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.9,
        reviewCount: 512,
        category: 'medicamentos',
      ),
      Product(
        id: '4',
        name: 'Antitérmico Infantil',
        price: 22.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 189,
        category: 'medicamentos',
      ),

      // Higiene
      Product(
        id: '5',
        name: 'Sabonete Líquido 250ml',
        price: 8.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.5,
        reviewCount: 478,
        category: 'higiene',
        isOnPromotion: true,
        discountPercentage: 25,
      ),
      Product(
        id: '6',
        name: 'Álcool Gel 500ml',
        price: 12.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.4,
        reviewCount: 645,
        category: 'higiene',
      ),
      Product(
        id: '7',
        name: 'Colgate Total 90g',
        price: 7.50,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 832,
        category: 'higiene',
        isOnPromotion: true,
        discountPercentage: 10,
      ),

      // Beleza
      Product(
        id: '8',
        name: 'Hidratante Facial 50ml',
        price: 59.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 392,
        category: 'beleza',
        isOnPromotion: true,
        discountPercentage: 30,
      ),
      Product(
        id: '9',
        name: 'Sérum Vitamina C',
        price: 89.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.9,
        reviewCount: 267,
        category: 'beleza',
      ),
      Product(
        id: '10',
        name: 'Protetor Solar FPS 50',
        price: 45.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.6,
        reviewCount: 521,
        category: 'beleza',
        isOnPromotion: true,
        discountPercentage: 20,
      ),

      // Suplementos
      Product(
        id: '11',
        name: 'Colágeno Hidrolisado',
        price: 78.90,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.8,
        reviewCount: 433,
        category: 'suplementos',
      ),
      Product(
        id: '12',
        name: 'Ômega 3 60 cápsulas',
        price: 55.00,
        imageUrl:
            'https://images.tcdn.com.br/img/img_prod/829162/produto_teste_nao_compre_81_1_2d7f0b8fa031db8286665740dd8de217.jpg',
        rating: 4.7,
        reviewCount: 356,
        category: 'suplementos',
        isOnPromotion: true,
        discountPercentage: 18,
      ),
    ];
  }
}
