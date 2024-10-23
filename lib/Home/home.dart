import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/Cart/cart.dart';

import 'package:pharmaplus/Home/categories.dart';
import 'package:pharmaplus/Home/searchBar.dart';
import 'package:pharmaplus/Home/verticalCard.dart';
import 'package:pharmaplus/models/imageCaching.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';
import 'package:pharmaplus/profile/profile.dart';
import 'package:pharmaplus/provider/alldrugs_provider.dart';

import 'package:pharmaplus/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int n0_notifications = 0;

DateTime hello = DateTime.now();

// more category info in whatsappgg 'me'

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final DataModel = Provider.of<AlldrugsProvider>(context);
    double Screen_width = MediaQuery.sizeOf(context).width;
    int currentHour = hello.hour;
    String? greetings;
    if (currentHour < 12) {
      setState(() {
        greetings = 'Good Morning';
      });
    } else if (currentHour < 18) {
      setState(() {
        greetings = 'Good Afternoon';
      });
    } else {
      setState(() {
        greetings = 'Good Evening';
      });
    }
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 94.5,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Profile())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            context.watch<ProfileProvider>().profileImage == ''
                                ? null
                                : CacheImage(
                                    imageUrl: context
                                        .watch<ProfileProvider>()
                                        .profileImage)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$greetings",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.merge(const TextStyle(fontSize: 12))),
                      Text(
                        context.watch<ProfileProvider>().name,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Text.rich(TextSpan(
                      text: "Points:",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${context.watch<ProfileProvider>().points}',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ])),
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
                  Badge(
                    offset: const Offset(-8, 0),
                    label: Text(
                      n0_notifications.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const InfoAlert(
                                    titletext: 'You have no notifications.');
                              });
                        },
                        icon: const Icon(Icons.notifications)),
                  ),
                ],
              ),
            ]),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showSearch(
                      context: context,
                      delegate:
                          CustomSearchbar(searchTerms: DataModel.allData));
                },
                child: Container(
                  width: Screen_width - 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 227, 224, 224),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search for a drug')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
                height: 90, width: double.infinity, child: Categories()),
            const SizedBox(
              height: 10,
            ),
            const verticalCard()
          ],
        ));
  }
}
