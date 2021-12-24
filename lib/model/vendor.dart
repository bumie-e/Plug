import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor{
  final String id;
  final String category;
  final String logoUrl;
  final String businessName;
  final String businessEmail;
  final String whatsappNumber;
  final String address;
  final String openingHours;
  final String closingHours;
  final String desc;

  Vendor({
    required this.id,
    required this.category,
    required this.logoUrl,
    required this.businessName,
    required this.businessEmail,
    required this.whatsappNumber,
    required this.address,
    required this.openingHours,
    required this.closingHours,
    required this.desc
  });

  factory Vendor.fromDocument(DocumentSnapshot doc) {
    return Vendor(
      id: doc.id,
      category: doc['category'],
      logoUrl: doc['logoUrl'],
      businessName: doc['businessName'],
      businessEmail: doc['businessEmail'],
      whatsappNumber: doc['whatsappNumber'],
      address: doc['address'],
      openingHours: doc['openingHours'],
      closingHours: doc['closingHours'],
      desc: doc['description']
    );
  }
}