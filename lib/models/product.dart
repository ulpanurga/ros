class Product {
  final String id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  final int discount;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.discount,
  });

  double get finalPrice => price * (100 - discount) / 100;

  factory Product.fromMap(String id, Map<String, dynamic> m) {
    return Product(
      id: id,
      name: m['name'] ?? '',
      category: m['category'] ?? '',
      image: m['image'] ?? '',
      description: m['description'] ?? '',
      price: (m['price'] ?? 0).toDouble(),
      discount: (m['discount'] ?? 0).toInt(),
    );
  }
}