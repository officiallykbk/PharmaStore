import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/orderComplete.dart';
import 'package:pharmaplus/models/address.dart';
import 'package:pharmaplus/models/order.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';

final _formkey = GlobalKey<FormState>();
final name = TextEditingController();
final phoneNO = TextEditingController();
final GPS = TextEditingController();
final info = TextEditingController();
final region = TextEditingController();
final city = TextEditingController();
final district = TextEditingController();
final landmark = TextEditingController();

String? _selectedItem;
List<String> _dropdownitems = [];

class Checkout extends StatelessWidget {
  const Checkout({super.key});
  @override
  Widget build(BuildContext context) {
    void clearFields() {
      name.clear();
      phoneNO.clear();
      GPS.clear();
      info.clear();
      region.clear();
      city.clear();
      district.clear();
      landmark.clear();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('PayUp Bitch'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const OrderSummary(),
              const Orders(),
              const ShippingDetails(),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.green),
                child: const ListTile(
                  leading: Icon(Icons.attach_money_sharp),
                  title: Text(
                    'Pay On Delivery',
                  ),
                  subtitle: Text('100% Delivery guarantee'),
                ),
              ),
              InkWell(
                onTap: () async {
                  bool valid = _formkey.currentState!.validate();
                  if (valid) {
                    try {
                      final newOrder = Order(
                              name: name.text,
                              address: Address(
                                  digitalAddress: GPS.text,
                                  region: region.text,
                                  city: city.text,
                                  district: district.text,
                                  landmark: landmark.text,
                                  phoneNumber: phoneNO.text,
                                  additionalInfo: info.text),
                              cart: PersistentShoppingCart()
                                  .getCartData()['cartItems'],
                              total: PersistentShoppingCart()
                                  .calculateTotalPrice())
                          .toJson();

                      await addOrder(newOrder);
                      print('Order made successfully');
                      CustomSnackBar.show(context, 'Order placed', Icons.check);

                      Future.delayed(Duration(milliseconds: 100), () {
                        _formkey.currentState?.reset();
                        clearFields();
                      });
                      PersistentShoppingCart().clearCart();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const OrderComplete()));
                    } catch (e) {
                      print('Failed to make order ${e}');
                      CustomSnackBar.show(
                          context, 'Order unsuccessful', Icons.error,
                          backgroundColor: Colors.red);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 255, 200, 0)),
                  child: Text(
                    'Place Order',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> shoppingcart = PersistentShoppingCart().getCartData();
    List<PersistentShoppingCartItem> CartItem = shoppingcart['cartItems'];
    return IntrinsicHeight(
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Total: ${PersistentShoppingCart().calculateTotalPrice()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: SizedBox(
                  height: 40,
                  child: Image.asset('assets/pill.png'),
                ),
                title: Text(
                  CartItem[0].productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'QTY: ${CartItem[0].quantity}',
                ),
                trailing: Text(
                  'GH¢${double.parse(CartItem[0].unitPrice.toString()) * double.parse(CartItem[0].quantity.toString())}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    style: TextButton.styleFrom(shape: const StadiumBorder()),
                    onPressed: () {
                      _showOrderDetailsDialog(context, CartItem);
                    },
                    child: const Text(
                      'See More',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
            ],
          )),
    );
  }
}

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> shoppingcart = PersistentShoppingCart().getCartData();
    List<PersistentShoppingCartItem> CartItem = shoppingcart['cartItems'];
    return Column(
      children: [
        const Divider(),
        Text(
          'Order Summary',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Order Summary',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: CartItem.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 40,
                                  child: Image.asset('assets/pill.png'),
                                ),
                                title: Text(
                                  CartItem[index].productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text.rich(TextSpan(
                                    text: 'QTY: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                    children: [
                                      TextSpan(
                                          text: '${CartItem[index].quantity}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ])),
                                trailing: Text(
                                  'GH¢${double.parse(CartItem[index].unitPrice.toString()) * double.parse(CartItem[index].quantity.toString())}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            'Total: GH¢${PersistentShoppingCart().calculateTotalPrice()}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: ListTile(
              leading: Text(
                'ITEMS (${PersistentShoppingCart().getCartItemCount()})',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class ShippingDetails extends StatefulWidget {
  const ShippingDetails({super.key});

  @override
  State<ShippingDetails> createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  // @override
  // void dispose() {
  //   name.dispose();
  //   phoneNO.dispose();
  //   GPS.dispose();
  //   info.dispose();
  //   region.dispose();
  //   city.dispose();
  //   district.dispose();
  //   landmark.dispose();
  //   super.dispose();
  // }

  bool showAddress = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text(
            'Shipping Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field can not be empty';
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: TextFormField(
              controller: phoneNO,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a phone number';
                } else if (!(RegExp(r"^(\+233|0)?[0-9]{9}$").hasMatch(value))) {
                  return 'Phone number can only be numbers';
                } else {
                  return null;
                }
              },
            ),
          ),

          // todo autocomplete widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: TextFormField(
              controller: GPS,
              decoration: InputDecoration(
                labelText: 'Ghana Post Address',
                border: OutlineInputBorder(),
                prefixIcon: TextButton(
                    onPressed: () async {
                      final Useraddress = await fetchAddress(GPS.text);

                      // we are going to save the editted address AS Address instead not ghanapost address
                      setState(() {
                        if (Useraddress != null) {
                          region.text = Useraddress.region;
                          city.text = Useraddress.city;
                          district.text = Useraddress.district;
                          landmark.text = Useraddress.landmark;
                          showAddress = true;
                        } else {
                          showAddress = false;
                          CustomSnackBar.show(context,
                              'Invalid Ghana Post Address', Icons.error,
                              backgroundColor: Colors.red);
                        }
                      });
                    },
                    child: const Text('Check')),
                suffixIcon: DropdownButton(
                  elevation: 0,
                  onChanged: (newValue) {
                    setState(() {
                      GPS.text = newValue as String;
                    });
                  },
                  items: _dropdownitems.map((option) {
                    return DropdownMenuItem(
                      child: Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty && showAddress == false) {
                  return 'Field can not be empty.\nEnter AK-000-0000, check and fill popup form below';
                } else {
                  return null;
                }
              },
            ),
          ),
          Visibility(
              visible: showAddress,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: TextFormField(
                      controller: region,
                      decoration: const InputDecoration(
                        labelText: 'Region',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: TextFormField(
                      controller: city,
                      decoration: const InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: TextFormField(
                      controller: district,
                      decoration: const InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: TextFormField(
                      controller: landmark,
                      decoration: const InputDecoration(
                        labelText: 'LandMark',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: TextFormField(
              controller: info,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Additional Information',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field can not be empty';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showOrderDetailsDialog(
    BuildContext context, List<PersistentShoppingCartItem> CartItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Order Details'),
        content: SizedBox(
          height: 300, // Set a fixed height for the dialog box
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: CartItem.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  height: 40,
                  child: Image.asset('assets/pill.png'),
                ),
                title: Text(
                  CartItem[index].productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'QTY: ${CartItem[index].quantity}\tTotal: ${double.parse(CartItem[index].unitPrice.toString()) * double.parse(CartItem[index].quantity.toString())}',
                ),
              );
            },
          ),
        ),
        actions: [
          Center(
            child: Text(
              'GH¢${PersistentShoppingCart().calculateTotalPrice()}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
