class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final double price;
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'price': price,
      'description': description,
      'rating': rating,
    };
  }
}
