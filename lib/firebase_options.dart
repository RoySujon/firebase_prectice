// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcZdde3KZMv-L89UxrdnK49lHHk7QlmrY',
    appId: '1:943158798043:android:7b643d6f6c0e55ff9b4efe',
    messagingSenderId: '943158798043',
    projectId: 'fir-demo-40b45',
    databaseURL: 'https://fir-demo-40b45-default-rtdb.firebaseio.com',
    storageBucket: 'fir-demo-40b45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMHtNfJPNabhzHZxbfG51wseX0FpJzgiA',
    appId: '1:943158798043:ios:bc0443dd00e2860e9b4efe',
    messagingSenderId: '943158798043',
    projectId: 'fir-demo-40b45',
    databaseURL: 'https://fir-demo-40b45-default-rtdb.firebaseio.com',
    storageBucket: 'fir-demo-40b45.appspot.com',
    androidClientId: '943158798043-j8bb131r7ap8oc57m65lqfe47i22a81h.apps.googleusercontent.com',
    iosClientId: '943158798043-f5ohi7dgooni2pv9jpiqh5gd3a83u4gn.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseDemo',
  );
}
