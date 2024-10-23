import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'Anonymous';
  String _email = 'anon@pharmastore.com';
  String _profileImage = '';
  int _points = 10;
  String get name => _name;
  String get email => _email;
  String get profileImage => _profileImage;
  int get points => _points;
  setname(value) async {
    _name = value;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .update({'name': value});
    notifyListeners();
  }

  // setemail(value) async {
  //   _email = value;
  //   var user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user!.uid)
  //       .update({'email': value});
  //   notifyListeners();
  // }

  setprofileImg(imageRef) async {
    _profileImage = imageRef;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .update({'profileImage': imageRef});
    notifyListeners();
  }

  GetInfo(details) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .get();
      if (snapshot.exists) {
        _name = snapshot.data()!['name'];
        _email = snapshot.data()!['email'];
        _profileImage = snapshot.data()!['profileImage'];
        _points = snapshot.data()!['points'];
      } else {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'name': details['name'],
          'email': details['email'],
          'profileImage': details['profileImage'],
          'points': 10
        });
        _name = details['name'];
        _email = details['email'];
        _profileImage = details['profileImage'];
      }
      print('User added or updated successfully');
    } catch (e) {
      print('User updating error $e');
    }
    notifyListeners();
  }
}
