import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/totalsheet.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: CartView(),
        bottomSheet: TotalCheckout());
  }
}

class CartView extends StatefulWidget {
  final double bottomspacing;
  const CartView({super.key, this.bottomspacing = 100});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PersistentShoppingCart().showCartItems(
                cartTileWidget: ({required data}) => Stack(children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/pill.png',
                            ),
                            title: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.productName,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text.rich(TextSpan(
                                    text: 'Price:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.merge(
                                          TextStyle(fontSize: 18),
                                        ),
                                    children: [
                                      TextSpan(
                                          text: ' GH¢${data.unitPrice}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ]))
                              ],
                            ),
                            // Text.rich(
                            //     maxLines: 2,
                            //     overflow: TextOverflow.ellipsis,
                            //     TextSpan(
                            //         text: '${data.productName}',
                            //         style:
                            //             Theme.of(context).textTheme.titleLarge,
                            //         children: [
                            //           TextSpan(
                            //             text: '\nPrice: GH¢${data.unitPrice}',
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .titleMedium
                            //                 ?.merge(TextStyle(fontSize: 18)),
                            //           )
                            //         ])),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                    onPressed: () {
                                      PersistentShoppingCart()
                                          .decrementCartItemQuantity(
                                              data.productId);
                                    },
                                    child: Text('-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)),
                                Text(data.quantity.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: CircleBorder()),
                                    onPressed: () {
                                      PersistentShoppingCart()
                                          .incrementCartItemQuantity(
                                              data.productId);
                                    },
                                    child: Text('+',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            PersistentShoppingCart()
                                .removeFromCart(data.productId);
                            CustomSnackBar.show(
                              context,
                              'Item removed from cart',
                              Icons.error,
                            );
                          },
                          icon: Icon(Icons.delete_outline),
                          color: Colors.red,
                        ),
                      ),
                    ]),
                showEmptyCartMsgWidget: Center(
                  child: Text("Cart is empty",
                      style: Theme.of(context).textTheme.titleLarge),
                )),
          ),
        ),
        SizedBox(
          height: widget.bottomspacing,
        )
      ],
    );
  }
}
