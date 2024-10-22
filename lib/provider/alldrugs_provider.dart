import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlldrugsProvider with ChangeNotifier {
  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  List _allData = [];
  List get allData => _allData;

  Future<void> getfileData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Drugs').get();

    List<Map<String, dynamic>> drugs = querySnapshot.docs.map((doc) {
      return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    }).toList();
    _allData = drugs;
    notifyListeners();
  }

  sort(String criteria) {
    _allData.sort((a, b) => a[criteria].compareTo(b[criteria]));
    notifyListeners();
  }
}
