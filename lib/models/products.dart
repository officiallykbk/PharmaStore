import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  // date added
  final String Brand_Name;
  final String Generic_Name;
  final String Manufacturer;
  final String description;
  final String Image_link;
  final String review;
  final double price;
  final String category;
  final double rate;
  final Timestamp? createdAt;

  Products({
    required this.Brand_Name,
    required this.Generic_Name,
    required this.Manufacturer,
    required this.description,
    required this.Image_link,
    this.review = '',
    required this.price,
    required this.category,
    this.rate = 0,
    this.createdAt,
  });
  // Convert Products object to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      "Brand_Name": Brand_Name,
      "Generic_Name": Generic_Name,
      "Manufacturer": Manufacturer,
      "description": description,
      "Image_link": Image_link,
      "review": review,
      "price": price,
      "category": category,
      "rate": rate,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
