// import 'package:flutter/material.dart';
// import 'package:pharmaplus/models/shopitems.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartProvider extends ChangeNotifier {
//   // variables
//   int cartNumber = 0;
//   double total = 0.0;
//   List<shopItem> cart = [];

//   // gettters
//   List<shopItem> get _cart => cart;
//   int get _cartNumber => cartNumber;
//   double get _total => total;

// // Increase overall cart number
//   IncreaseCartNumber() {
//     cartNumber += 1;
//     notifyListeners();
//   }

// // decrease overall cart number
//   decreaseCartNumber() {
//     cartNumber -= 1;
//     notifyListeners();
//   }

//   // Check if a product is in the cart
//   void checkCart(shopItem product) {
//     bool itemExists = false;

//     for (shopItem item in cart) {
//       if (item.name == product.name) {
//         itemExists = true;
//         item.quantity += 1; // Increment quantity if product exists in cart
//         total += item.price;
//         break;
//       }
//     }

//     if (!itemExists) {
//       cart.add(product); // Add new product if it doesn't exist in cart
//       total += product.price;
//     }

//     notifyListeners();
//   }

//   // Increase the quantity of a specific item
//   void increaseItemQuantity(shopItem product) {
//     for (shopItem item in cart) {
//       if (item.name == product.name) {
//         item.quantity += 1;
//         total += item.price;
//         break;
//       }
//     }
//     notifyListeners();
//   }

//   // Decrease the quantity of a specific item
//   void decreaseItemQuantity(shopItem product) {
//     for (shopItem item in cart) {
//       if (item.name == product.name) {
//         if (item.quantity > 1) {
//           item.quantity -= 1;
//           total -= item.price;
//         } else {
//           total -= item.price;
//           cart.remove(item);
//         }
//         break;
//       }
//     }
//     notifyListeners();
//   }

//   rmFromCart(shopItem item) {
//     for (shopItem element in cart) {
//       if (element.name == item.name) {
//         cartNumber -= element.quantity;
//         total -= element.price * element.quantity;
//       }
//     }
//     cart.remove(item);
//     notifyListeners();
//   }

//   settotal(double setter) {
//     // for (shopItem element in cart) {
//     //   total += element.price * element.quantity;
//     // }
//     total -= setter;
//     notifyListeners();
//   }
// }

// Future<SharedPreferences> getSharedPrefs() async {
//   return await SharedPreferences.getInstance();
// }

// Future<void> setString(String key, String value) async {
//   final SharedPreferences prefs = await getSharedPrefs();
//   prefs.setString('name$key', value);
// }

// Future<String?> getString(String key) async {
//   final SharedPreferences prefs = await getSharedPrefs();
//   return prefs.getString('name$key');
// }
//   // Future<int> getInt(String key) async{
//   //       final SharedPreferences prefs = await getSharedPrefs();
//   //       totalnumber=prefs.getInt('name0');
//   // }