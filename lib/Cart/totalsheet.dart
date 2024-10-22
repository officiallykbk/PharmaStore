import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/Checkout.dart';
import 'package:pharmaplus/Home/home.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';

class TotalCheckout extends StatefulWidget {
  const TotalCheckout({super.key});

  @override
  State<TotalCheckout> createState() => _TotalCheckoutState();
}

bool btnVisible = true;

class _TotalCheckoutState extends State<TotalCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: false, //btnVisible,
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintText: '${points} points = Gh¢${points * 0.001}',
                    suffix: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            btnVisible = false;
                          });
                          // context
                          //     .read<CartProvider>()
                          //     .settotal((points * 0.001));
                        },
                        child: Text(
                          'Use Points',
                        )),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  PersistentShoppingCart().showTotalAmountWidget(
                      cartTotalAmountWidgetBuilder: (total) {
                    return Text(
                      total.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  })
                ],
              ),
              InkWell(
                onTap: () {
                  if (PersistentShoppingCart().calculateTotalPrice() != 0) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Checkout()));
                  } else {
                    CustomSnackBar.show(context, 'Cart is empty', Icons.error,
                        backgroundColor: Colors.red);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                  child: Text(
                    'Checkout',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
