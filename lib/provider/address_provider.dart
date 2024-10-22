import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaplus/models/address.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> _address = [];
  List<Address> get address => _address;
  void getAddress(Address address) {
    _address.add(address);
    notifyListeners();
  }

  Future<void> addAddress(Address address) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    try {
      await _firestore.collection('users').doc(user?.uid).set({
        // 'address': address.toJson(),
        'addresses': FieldValue.arrayUnion([address.toJson()]),
      }, SetOptions(merge: true));
      print('Address added successfully!');
    } catch (e) {
      print('Error adding address: $e');
    }
    notifyListeners();
  }
}
