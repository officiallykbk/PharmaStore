// import 'package:flutter/material.dart';
// import 'package:pharmaplus/Cart/shopitems.dart';
// import 'package:pharmaplus/Home/drugDetails.dart';
// import 'package:pharmaplus/provider/alldrugs_provider.dart';
// import 'package:pharmaplus/provider/cart_provider.dart';
// import 'package:provider/provider.dart';

// int discount = 0;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List finalList = [];

//   @override
//   void initState() {
//     super.initState();
//     final DataModel = Provider.of<AlldrugsProvider>(context, listen: false);
//     finalList = DataModel.allData;
//   }

//   DataFilter(String enteredValue) {
//     setState(() {
//       if (enteredValue.isEmpty) {
//         finalList =
//             Provider.of<AlldrugsProvider>(context, listen: false).allData;
//       } else {
//         finalList = Provider.of<AlldrugsProvider>(context, listen: false)
//             .allData
//             .where((item) =>
//                 item['Brand_Name']!
//                     .toLowerCase()
//                     .contains(enteredValue.toLowerCase()) ||
//                 item['Generic_Name']!
//                     .toLowerCase()
//                     .contains(enteredValue.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: PreferredSize(
//             preferredSize: Size(double.infinity, 70),
//             child: Center(
//                 child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 onChanged: (value) => DataFilter(value),
//                 decoration: InputDecoration(
//                     hintText: 'Search for a drug',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20))),
//               ),
//             ))),
//       ),
//       body: FutureBuilder<void>(
//         future: Future.delayed(Duration(seconds: 2)),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading data'));
//           } else {
//             return finalList.isEmpty
//                 ? Center(
//                     child: Text(
//                     'Nothing to sell Yet',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ))
//                 : Expanded(
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                       ),
//                       itemCount: finalList.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (_) =>
//                                       drugView(drugModel: finalList[index])));
//                             },
//                             child: Card(
//                               child: Column(
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       Container(
//                                         height: 100,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Image.asset('assets/pill.png'),
//                                       ),
//                                       Positioned(
//                                         top: 0,
//                                         left: 0,
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               color: const Color.fromARGB(
//                                                   255, 222, 200, 6),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 5.0),
//                                               child: Text(
//                                                 '${discount}% off',
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     finalList[index]['Brand_Name'].length < 20
//                                         ? '${finalList[index]['Brand_Name']}'
//                                         : '${finalList[index]['Brand_Name'].substring(0, 20)}...',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Text.rich(TextSpan(
//                                           text: 'Price: ',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium,
//                                           children: [
//                                             TextSpan(
//                                               text:
//                                                   'Gh₵${finalList[index]['price']}',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleMedium,
//                                             )
//                                           ])),
//                                       IconButton(
//                                           onPressed: () {
//                                             final product = shopItem(
//                                               name: finalList[index]
//                                                   ['Brand_Name'],
//                                               price: finalList[index]['price'],
//                                               quantity: 1,
//                                             );
//                                             context
//                                                 .read<CartProvider>()
//                                                 .checkCart(product);
//                                             context
//                                                 .read<CartProvider>()
//                                                 .IncreaseCartNumber();
//                                           },
//                                           icon: Container(
//                                               decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.grey),
//                                               child: const Icon(Icons.add)))
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//           }
//         },
//       ),
//     );
//   }
// }
