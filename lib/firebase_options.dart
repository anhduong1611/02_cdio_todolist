
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB0u2AZVMuks0-u4KWSnsLSZwEHuZaLyaE',
    appId: '1:597680831996:web:69d507c3b04965a695c679',
    messagingSenderId: '597680831996',
    projectId: 'cdio02new',
    authDomain: 'cdio02new.firebaseapp.com',
    storageBucket: 'cdio02new.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrsnlnucIVXHCcCSBIqtJQck5AxqoVm-I',
    appId: '1:597680831996:android:9d6a863741e2788995c679',
    messagingSenderId: '597680831996',
    projectId: 'cdio02new',
    storageBucket: 'cdio02new.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAF8HYCG4Iw0i03jLJcaVvGwJlnDo6bx48',
    appId: '1:597680831996:ios:dc94c24b3095fff895c679',
    messagingSenderId: '597680831996',
    projectId: 'cdio02new',
    storageBucket: 'cdio02new.appspot.com',
    androidClientId: '597680831996-s2d69tbgqvkpgdfgm0d6j7h44bi6k5fv.apps.googleusercontent.com',
    iosClientId: '597680831996-8kjtfus38maf7auqkiflft4dq7vu99mv.apps.googleusercontent.com',
    iosBundleId: 'com.example.cdio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAF8HYCG4Iw0i03jLJcaVvGwJlnDo6bx48',
    appId: '1:597680831996:ios:dc94c24b3095fff895c679',
    messagingSenderId: '597680831996',
    projectId: 'cdio02new',
    storageBucket: 'cdio02new.appspot.com',
    androidClientId: '597680831996-s2d69tbgqvkpgdfgm0d6j7h44bi6k5fv.apps.googleusercontent.com',
    iosClientId: '597680831996-8kjtfus38maf7auqkiflft4dq7vu99mv.apps.googleusercontent.com',
    iosBundleId: 'com.example.cdio',
  );
}
