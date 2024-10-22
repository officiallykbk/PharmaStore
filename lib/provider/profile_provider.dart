import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'Anonymous';
  String _email = 'anon@pharmastore.com';
  String _profileImage = '';
  String get name => _name;
  String get email => _email;
  String get profileImage => _profileImage;
  setname(value) async {
    _name = value;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .set({'name': value});
    notifyListeners();
  }

  // setemail(value) async {
  //   _email = value;
  //   var user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user!.uid)
  //       .set({'email': value});
  //   notifyListeners();
  // }

  setprofileImg(imageRef) async {
    _profileImage = imageRef;
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .set({'profileImage': imageRef});
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
      } else {
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'name': details['name'],
          'email': details['email'],
          'profileImage': details['profileImage'],
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
