class Product{
  final String id;
  final String category;
  final String name;
  final String price;
  final String photoUrl;
  final String description;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.photoUrl,
    required this.description,
  });

  factory Product.fromDocument({
    required Map<String, dynamic> data
  }) {
    return Product(
      id: data['id'],
      category: data['category'],
      name: data['productName'],
      price: data['price'],
      photoUrl: data['productImageUrl'],
      description: data['description']
    );
  }
}