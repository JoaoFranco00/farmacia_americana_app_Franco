class Product {
  final String id;
  final String name;
  final String description; 
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
    required this.description, 
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isOnPromotion = false,
    this.discountPercentage,
  });
}