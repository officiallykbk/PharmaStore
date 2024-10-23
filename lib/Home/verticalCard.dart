import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Home/drugDetails.dart';
import 'package:pharmaplus/models/imageCaching.dart';
import 'package:pharmaplus/provider/alldrugs_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

int discount = 0;

class verticalCard extends StatefulWidget {
  const verticalCard({super.key});

  @override
  State<verticalCard> createState() => _verticalCardState();
}

class _verticalCardState extends State<verticalCard> {
  @override
  Widget build(BuildContext context) {
    final DataModel = Provider.of<AlldrugsProvider>(context);
    return
        // Consumer<CartProvider>(builder: (context, cartProvider, child) =>
        DataModel.allData.isEmpty
            ? const Center(
                child: SpinKitSquareCircle(
                color: Colors.blue,
              ))
            : Expanded(
                child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: DataModel.allData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => drugView(
                                  drugModel: DataModel.allData[index])));
                        },
                        child: Card(
                            child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Hero(
                                      transitionOnUserGestures: true,
                                      tag:
                                          '${DataModel.allData[index]['Brand_Name']}',
                                      child: CacheImage(
                                          imageUrl: DataModel.allData[index]
                                              ['Image_link'])),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 222, 200, 6),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: discount != 0
                                              ? Text(
                                                  '${discount}% off',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : null)),
                                ),
                              ],
                            ),
                            Text(
                              '${DataModel.allData[index]['Brand_Name']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text.rich(TextSpan(
                                    text: 'Price: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            'Gh₵${DataModel.allData[index]['price']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ])),
                                PersistentShoppingCart()
                                    .showAndUpdateCartItemWidget(
                                        inCartWidget: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        notInCartWidget: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey),
                                            child: const Icon(Icons.add)),
                                        product: PersistentShoppingCartItem(
                                            productId: DataModel.allData[index]
                                                    ['id']
                                                .toString(),
                                            productName: DataModel
                                                .allData[index]['Brand_Name'],
                                            productThumbnail: DataModel
                                                .allData[index]['Image_link'],
                                            unitPrice: double.parse(DataModel
                                                .allData[index]['price']
                                                .toString()),
                                            quantity: 1))
                              ],
                            ),
                          ],
                        ))),
                  );
                },
              ));
  }
}
