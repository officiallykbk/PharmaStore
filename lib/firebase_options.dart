// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjxcqWgmPbdz769mHpc8X5Wm-i5-a68Rk',
    appId: '1:1037237161880:web:980cf098fa16df008e25ed',
    messagingSenderId: '1037237161880',
    projectId: 'pharmastore-29ac5',
    authDomain: 'pharmastore-29ac5.firebaseapp.com',
    storageBucket: 'pharmastore-29ac5.appspot.com',
    measurementId: 'G-9R3GPYBYS0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjVGTtC3Z4EeDOWOFwcDP6wioEkVfmLQg',
    appId: '1:1037237161880:android:08d7991879750b5b8e25ed',
    messagingSenderId: '1037237161880',
    projectId: 'pharmastore-29ac5',
    storageBucket: 'pharmastore-29ac5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhqFyCJnkSZTSiFKdeHBQ9jgKAoNsknFg',
    appId: '1:1037237161880:ios:945d814c8085acd68e25ed',
    messagingSenderId: '1037237161880',
    projectId: 'pharmastore-29ac5',
    storageBucket: 'pharmastore-29ac5.appspot.com',
    iosClientId: '1037237161880-5726dc63sv60katqpks4r79i6ohfc7or.apps.googleusercontent.com',
    iosBundleId: 'com.example.pharmaplus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhqFyCJnkSZTSiFKdeHBQ9jgKAoNsknFg',
    appId: '1:1037237161880:ios:945d814c8085acd68e25ed',
    messagingSenderId: '1037237161880',
    projectId: 'pharmastore-29ac5',
    storageBucket: 'pharmastore-29ac5.appspot.com',
    iosClientId: '1037237161880-5726dc63sv60katqpks4r79i6ohfc7or.apps.googleusercontent.com',
    iosBundleId: 'com.example.pharmaplus',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjxcqWgmPbdz769mHpc8X5Wm-i5-a68Rk',
    appId: '1:1037237161880:web:c1e6a1e1383d45088e25ed',
    messagingSenderId: '1037237161880',
    projectId: 'pharmastore-29ac5',
    authDomain: 'pharmastore-29ac5.firebaseapp.com',
    storageBucket: 'pharmastore-29ac5.appspot.com',
    measurementId: 'G-2DD4HDMRLD',
  );

}