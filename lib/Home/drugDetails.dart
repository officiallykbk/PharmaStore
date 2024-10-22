import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/cart.dart';

class drugView extends StatelessWidget {
  const drugView({super.key, this.drugModel});

  final drugModel;
  @override
  Widget build(BuildContext context) {
    List price = ((drugModel['price'].toString()).split('.'));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_cart_checkout),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Hero(
                    tag: '${drugModel['Brand_name']}',
                    child: Image.asset('assets/pill.png'))),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                drugModel['Brand_Name'],
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.merge(TextStyle(fontSize: 30)),
              ),
            ),
            Text(drugModel['description'],
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'GH¢${price[0]}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.merge(TextStyle(fontSize: 30))),
                  TextSpan(
                      text: price.length == 1 ? '.00' : '.${price[1]}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.merge(TextStyle(fontSize: 18)))
                ]),
              ),
              PersistentShoppingCart().showAndUpdateCartItemWidget(
                  inCartWidget: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 248, 238, 224)),
                    child: Text(
                      'Item in Cart',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  notInCartWidget: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange),
                    child: Text(
                      'Add to Cart',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  product: PersistentShoppingCartItem(
                      productId: drugModel['id'].toString(),
                      productName: drugModel['Brand_Name'],
                      unitPrice: double.parse(drugModel['price'].toString()),
                      quantity: 1)),
              // InkWell(
              //   onTap: () {
              //     final product = shopItem(
              //       name: drugModel['Brand_Name'],
              //       price: drugModel['price'],
              //       quantity: 1,
              //     );
              //     // context.read<CartProvider>().checkCart(product);
              //     // context.read<CartProvider>().IncreaseCartNumber();

              //     CustomSnackBar.show(
              //         context, 'Item in cart', Icons.check);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: Colors.orange),
              //     child: Text(
              //       'Add to Cart',
              //       textAlign: TextAlign.center,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
