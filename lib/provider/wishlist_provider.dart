import 'package:flutter/material.dart';
import 'package:pharmaplus/models/shopitems.dart';

class WishlistProvider extends ChangeNotifier {
  List<shopItem> wishList = [];
  List<shopItem> get _wishlist => wishList;

  void checkWish(shopItem product) {
    bool itemExists = false;

    for (shopItem item in wishList) {
      if (item.name == product.name) {
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      wishList.add(product); // Add
    }

    notifyListeners();
  }

  rmFromCart(shopItem item) {
    wishList.remove(item);
    notifyListeners();
  }
}
