import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import 'package:pharmaplus/Home/drugDetails.dart';

class CustomSearchbar extends SearchDelegate {
  final List searchTerms;

  CustomSearchbar({required this.searchTerms});

  // Build the actions for the app bar (e.g., clear the query)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // Build the leading icon in the app bar (e.g., back arrow)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // Build the results based on the search query
  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];

    for (var item in searchTerms) {
      if (item['Brand_Name']!.toLowerCase().contains(query.toLowerCase()) ||
          item['Generic_Name']!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => drugView(drugModel: matchQuery[index])));
          },
          child: ListTile(
            leading: Image.asset('assets/pill.jpeg'),
            trailing: PersistentShoppingCart().showAndUpdateCartItemWidget(
                inCartWidget: Icon(Icons.check),
                notInCartWidget: Icon(Icons.add),
                product: PersistentShoppingCartItem(
                    productId: matchQuery[index]['id'],
                    productName: matchQuery[index]['Brand_Name'],
                    unitPrice: matchQuery[index]['price'],
                    quantity: 1)),
            // GestureDetector(
            //     onTap: () {
            //       final product = shopItem(
            //         name: matchQuery[index]['Brand_Name'],
            //         price: matchQuery[index]['price'],
            //         quantity: 1,
            //       );
            //       context.read<CartProvider>().checkCart(product);
            //       context.read<CartProvider>().IncreaseCartNumber();

            //     },
            //     child: Container(
            //         padding: EdgeInsets.all(5),
            //         decoration: BoxDecoration(color: Colors.grey),
            //         child: const Icon(Icons.add))),
            title: Text('${matchQuery[index]['Brand_Name']}'),
            subtitle: Text('Generic: ${matchQuery[index]['Generic_Name']}'),
          ),
        );
      },
    );
  }

  // Build suggestions as the user types
  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];

    for (var item in searchTerms) {
      if (item['Brand_Name']!.toLowerCase().contains(query.toLowerCase()) ||
          item['Generic_Name']!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => drugView(drugModel: matchQuery[index])));
          },
          child: ListTile(
            leading: Image.asset('assets/pill.jpeg'),
            trailing: PersistentShoppingCart().showAndUpdateCartItemWidget(
                inCartWidget: Icon(Icons.check),
                notInCartWidget: Icon(Icons.add),
                product: PersistentShoppingCartItem(
                    productId: matchQuery[index]['id'].toString(),
                    productName: matchQuery[index]['Brand_Name'],
                    unitPrice:
                        double.parse(matchQuery[index]['price'].toString()),
                    quantity: 1)),
            // GestureDetector(
            //     onTap: () {
            //       final product = shopItem(
            //         name: matchQuery[index]['Brand_Name'],
            //         price: matchQuery[index]['price'],
            //         quantity: 1,
            //       );
            //       context.read<CartProvider>().checkCart(product);
            //       context.read<CartProvider>().IncreaseCartNumber();
            //     },
            //     child: Container(
            //         padding: EdgeInsets.all(5),
            //         decoration: BoxDecoration(color: Colors.grey),
            //         child: const Icon(Icons.add))),
            title: Text('${matchQuery[index]['Brand_Name']}'),
            subtitle: Text('Generic: ${matchQuery[index]['Generic_Name']}'),
            // onTap: () {
            //   query = matchQuery[index]['Brand_Name']!;
            //   showResults(context);
            // },
          ),
        );
      },
    );
  }
}
