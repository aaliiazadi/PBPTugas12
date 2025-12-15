import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyDWWvjfQYyq0yGdwamfIfL4DgNBfVzq3C8',
    appId: '1:748826793316:web:6afe36f7cb178ec903d671',
    messagingSenderId: '748826793316',
    projectId: 'pbptugas12',
    authDomain: 'pbptugas12.firebaseapp.com',
    storageBucket: 'pbptugas12.firebasestorage.app',
    measurementId: 'G-R27GZSYZHW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7j6Jdg3VrrB9p5YE0w-E53SE5Z94xEP4',
    appId: '1:748826793316:android:13d285a921d198ec03d671',
    messagingSenderId: '748826793316',
    projectId: 'pbptugas12',
    storageBucket: 'pbptugas12.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZI0KHb4gOXMl_sQTGKrICjfe4MpzbUlo',
    appId: '1:748826793316:ios:78b13834825ae8cd03d671',
    messagingSenderId: '748826793316',
    projectId: 'pbptugas12',
    storageBucket: 'pbptugas12.firebasestorage.app',
    iosBundleId: 'com.example.tugas12Pbp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZI0KHb4gOXMl_sQTGKrICjfe4MpzbUlo',
    appId: '1:748826793316:ios:78b13834825ae8cd03d671',
    messagingSenderId: '748826793316',
    projectId: 'pbptugas12',
    storageBucket: 'pbptugas12.firebasestorage.app',
    iosBundleId: 'com.example.tugas12Pbp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWWvjfQYyq0yGdwamfIfL4DgNBfVzq3C8',
    appId: '1:748826793316:web:d9cb9fc93daba59c03d671',
    messagingSenderId: '748826793316',
    projectId: 'pbptugas12',
    authDomain: 'pbptugas12.firebaseapp.com',
    storageBucket: 'pbptugas12.firebasestorage.app',
    measurementId: 'G-SRSJ80JHYV',
  );
}
