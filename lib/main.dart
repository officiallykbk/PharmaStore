import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import 'package:pharmaplus/SignInPage.dart';
import 'package:pharmaplus/firebase_options.dart';
import 'package:pharmaplus/provider/alldrugs_provider.dart';
// import 'package:pharmaplus/provider/cart_provider.dart';
import 'package:pharmaplus/provider/profile_provider.dart';
import 'package:pharmaplus/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PersistentShoppingCart().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => WishlistProvider()),
    ChangeNotifierProvider(create: (_) => AlldrugsProvider()..getfileData()),
    // ChangeNotifierProvider(create: (_) => CartProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PharmaPlus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            textTheme: const TextTheme(
                titleLarge:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                titleMedium:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                titleSmall:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                bodyLarge: TextStyle(fontSize: 20),
                bodyMedium: TextStyle(fontSize: 15),
                bodySmall: TextStyle(fontSize: 12))),
        home: SignIn());
  }
}
