import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  final String id;
  final String name;
  final String price;
  final String photoUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.photoUrl,
    required this.description,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc['id'],
      name: doc['productName'],
      price: doc['price'],
      photoUrl: doc['productImageUrl'],
      description: doc['description']
    );
  }
}