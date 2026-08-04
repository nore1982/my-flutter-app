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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTesting123456789',
    appId: '1:1234567890:web:demo123456',
    messagingSenderId: '1234567890',
    projectId: 'demo-app-project',
    authDomain: 'demo-app-project.firebaseapp.com',
    storageBucket: 'demo-app-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTesting123456789',
    appId: '1:1234567890:android:demo123456',
    messagingSenderId: '1234567890',
    projectId: 'demo-app-project',
    storageBucket: 'demo-app-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTesting123456789',
    appId: '1:1234567890:ios:demo123456',
    messagingSenderId: '1234567890',
    projectId: 'demo-app-project',
    storageBucket: 'demo-app-project.appspot.com',
    iosBundleId: 'com.example.myApp',
  );
}