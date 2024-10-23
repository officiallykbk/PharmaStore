import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/orderComplete.dart';
import 'package:pharmaplus/models/address.dart';
import 'package:pharmaplus/models/imageCaching.dart';
import 'package:pharmaplus/models/order.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';

final _formkey = GlobalKey<FormState>();
final name = TextEditingController();
final phoneNO = TextEditingController();
final GPS = TextEditingController();
final GPSauto = TextEditingValue();
final info = TextEditingController();
final region = TextEditingController();
final city = TextEditingController();
final district = TextEditingController();
final landmark = TextEditingController();

String? _selectedItem;
List<String> _dropdownitems = ['AK-000-0000'];

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
              const OrderSummary(),
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

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

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
                                  height: 50,
                                  width: 50,
                                  child: CacheImage(
                                      imageUrl:
                                          CartItem[index].productThumbnail!),
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
            child: Autocomplete<String>(
              optionsBuilder: (GPSauto) {
                if (GPSauto.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _dropdownitems.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(GPSauto.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                print('You selected: $selection');
              },
              fieldViewBuilder: (BuildContext context, GPS, FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: GPS,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Ghana Post Address',
                    border: OutlineInputBorder(),
                    suffix: TextButton(
                        onPressed: () async {
                          final Useraddress = await fetchAddress(GPS.text);

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
                  ),
                  validator: (value) {
                    if (value!.isEmpty && showAddress == false) {
                      return 'Field can not be empty.\nEnter AK-000-0000, check and fill popup form below';
                    } else {
                      return null;
                    }
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                              _selectedItem = option;
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
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
            ),
          ),
        ],
      ),
    );
  }
}
