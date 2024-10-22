import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:pharmaplus/SignInPage.dart';
import 'package:pharmaplus/profile/AddressView.dart';
import 'package:pharmaplus/profile/EditProfile.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';
import 'package:pharmaplus/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    String avatarImage = context
        .watch<ProfileProvider>()
        .profileImage; // ?? Image.asset('assets/unknownPerson.png');
    String name = context.watch<ProfileProvider>().name;
    String email = context.watch<ProfileProvider>().email;
    double Screen_width = MediaQuery.sizeOf(context).width;
    double Screen_height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size(Screen_width, Screen_height * 0.3),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      avatarImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  email,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditProfile(
                            name: name,
                            email: email,
                            profileImg: avatarImage)));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    backgroundColor: Colors.black,
                  ),
                  child: Text('Edit',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.merge(const TextStyle(color: Colors.white))),
                ),
              ],
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Screen_width - 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 227, 224, 224),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'History',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Address()));
                    },
                    child: Text(
                      'Address',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return const InfoAlert(
                              titletext: 'Contact Us😷\n0501389629',
                            );
                          });
                    },
                    child: Text(
                      'Support',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showAboutDialog(
                        applicationName: 'Pharmastore',
                        applicationIcon: Container(
                            height: 40, child: Image.asset('assets/pill.png')),
                        context: context,
                        children: [
                          Text(
                              'A platform meant to ensure efficient supply of health medicines to the public'),
                        ],
                      );
                    },
                    child: Text(
                      'About',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog<bool>(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return YesAlert(
                              titletext: 'LogOut?',
                              subtext: 'Are you sure you want to signOut',
                            );
                          });
                      if (result == true) {
                        await FirebaseAuth.instance.signOut();
                        PersistentShoppingCart().clearCart();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: Text(
                      'LogOut',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.merge(const TextStyle(color: Colors.red)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
