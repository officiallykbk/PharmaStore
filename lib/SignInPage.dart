import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmaplus/Home/home.dart';
import 'package:pharmaplus/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController Username = TextEditingController();

class _SignInState extends State<SignIn> {
  void updateProfileInfo() {
    try {
      print('printing profile');
      // print(Username.text);
      print(_user);
      final profileProvider = context.read<ProfileProvider>();
      final details = {
        'name': _user?.additionalUserInfo!.profile!['given_name'],
        'email': _user?.additionalUserInfo!.profile!['email'],
        'profileImage': _user?.additionalUserInfo!.profile!['picture']
      };
      profileProvider.GetInfo(details);

      //   profileProvider
      //       .setname(Username.text.length == 0 ? 'Anonymous' : Username.text);
      //   profileProvider.setemail(_user?.email ?? 'anon@pharmastore.com');
    } catch (e) {
      print('Problem with updating profile ${e}');
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User? _user;
  // @override
  // void initState() {
  //   super.initState();
  //   _auth.authStateChanges().listen((event) {
  //     setState(() {
  //       _user = event;
  //     });
  //   });
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? _user;
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Use signInWithPopup
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        _user = await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile: Use GoogleSignIn package
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          _user = await _auth.signInWithCredential(credential);
        }
        Username.text = _user?.additionalUserInfo!.profile!['given_name'];
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Pill.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer(
              builder: (context, profileProvider, child) => _user == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                margin: const EdgeInsets.only(top: 100),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    ScaleAnimatedText(
                                      'Welcome',
                                      textStyle: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ScaleAnimatedText(
                                      'To',
                                      textStyle: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ScaleAnimatedText(
                                      'PharmaStore',
                                      textStyle: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 100),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SignInButton(
                                onPressed: () async {
                                  try {
                                    print('signing in with google');
                                    // GoogleAuthProvider _googleauthProvider =
                                    //     GoogleAuthProvider();
                                    // _auth.signInWithProvider(_googleauthProvider);

                                    await signInWithGoogle();
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      updateProfileInfo();
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                  } catch (error) {
                                    print('Error occured ${error}');
                                  }
                                },
                                Buttons.google,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const HomePage())),
    );
  }
}
