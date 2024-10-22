// import 'package:flutter/material.dart';
// import 'package:pharmaplus/Cart/cart.dart';
// import 'package:pharmaplus/Home/home.dart';
// import 'package:pharmaplus/profile.dart';

// class Navbar extends StatefulWidget {
//   Navbar({super.key, required this.currentIndex});

//   @override
//   State<Navbar> createState() => _NavbarState();
//   int currentIndex;
// }

// List<Widget> pages = [
//   const HomePage(),
//   const Cart(),
//   const Profile(),
// ];

// class _NavbarState extends State<Navbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: pages[widget.currentIndex],
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
//           child: NavigationBar(
//             destinations: const [
//               NavigationDestination(icon: Icon(Icons.store_rounded), label: ''),
//               NavigationDestination(icon: Icon(Icons.shopping_cart), label: ''),
//               NavigationDestination(icon: Icon(Icons.person), label: ''),
//               // Planning to add a dictionary section where drug info can be looked up
//             ],
//             onDestinationSelected: (index) {
//               setState(() {
//                 widget.currentIndex = index;
//               });
//             },
//             selectedIndex: widget.currentIndex,
//             height: 80,
//             indicatorShape: const CircleBorder(eccentricity: 0.4),
//             // indicatorColor: Colors.green,
//           ),
//         ));
//   }
// }
