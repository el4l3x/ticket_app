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
      /* throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ); */
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
    apiKey: 'AIzaSyBolOM-wXqtNVu92Du6SsPGnkAnzvORrq8',
    appId: '1:395977125298:web:69136366154feecb3708ab',
    messagingSenderId: '395977125298',
    projectId: 'tickets-app-ea141',
    authDomain: 'tickets-app-ea141.firebaseapp.com',
    storageBucket: 'tickets-app-ea141.appspot.com',
    measurementId: 'G-RRTZH24EG0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvnWcNx3K-Gu7HIZRP47aSjA2lcwEnZfI',
    appId: '1:395977125298:android:be47d347f0dd23c83708ab',
    messagingSenderId: '395977125298',
    projectId: 'tickets-app-ea141',
    storageBucket: 'tickets-app-ea141.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDohLDi5fHqwxllHCtntZ2VcOklTsIrW2A',
    appId: '1:395977125298:ios:7e2188a04562cbeb3708ab',
    messagingSenderId: '395977125298',
    projectId: 'tickets-app-ea141',
    storageBucket: 'tickets-app-ea141.appspot.com',
    iosBundleId: 'com.example.ticketApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDohLDi5fHqwxllHCtntZ2VcOklTsIrW2A',
    appId: '1:395977125298:ios:e73cef2e77b507613708ab',
    messagingSenderId: '395977125298',
    projectId: 'tickets-app-ea141',
    storageBucket: 'tickets-app-ea141.appspot.com',
    iosBundleId: 'com.example.ticketApp.RunnerTests',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvnWcNx3K-Gu7HIZRP47aSjA2lcwEnZfI',
    appId: '1:395977125298:android:be47d347f0dd23c83708ab',
    messagingSenderId: '395977125298',
    projectId: 'tickets-app-ea141',
  );
}
