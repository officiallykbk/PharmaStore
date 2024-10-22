import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:pharmaplus/models/address.dart';

class Order {
  String? userId;
  String name;
  Address address;
  List<PersistentShoppingCartItem> cart;
  double total;
  String orderStatus;
  Timestamp? orderDate;

  Order(
      {this.userId,
      required this.name,
      required this.address,
      required this.cart,
      required this.total,
      this.orderStatus = 'pending',
      this.orderDate});

  List<Map<String, dynamic>> toMapList() {
    return cart.map((item) => item.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId ?? FirebaseAuth.instance.currentUser?.uid,
      'name': name,
      'address': address.toJson(),
      'cart': toMapList(),
      'total': total,
      'orderStatus': orderStatus,
      'orderDate': orderDate ?? FieldValue.serverTimestamp(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['userId'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      cart: json['cart'],
      total: json['total'],
      orderStatus: json['orderStatus'],
      orderDate: json['orderDate'],
    );
  }
}

Future<void> addOrder(order) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    await _firestore.collection('Orders').add(order);

    print('Order added successfully!');
  } catch (e) {
    print('Error adding order: $e');
  }
}
