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
    apiKey: 'AIzaSyDVidRZ7CzfVLkgxyZ7YsMhzxKyvzaZHAc',
    appId: '1:952851426705:web:0a2c0c5442a0115abbfe30',
    messagingSenderId: '952851426705',
    projectId: 'baskonuscevir',
    authDomain: 'baskonuscevir.firebaseapp.com',
    storageBucket: 'baskonuscevir.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvronPSVhE979akIxsIGebjRnSj3SWzMs',
    appId: '1:952851426705:android:586ca78ee32e3248bbfe30',
    messagingSenderId: '952851426705',
    projectId: 'baskonuscevir',
    storageBucket: 'baskonuscevir.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcWpqKb9-fOlh7f3Eq3v0u91JEZ_D2dzw',
    appId: '1:952851426705:ios:efca295d1fd28c25bbfe30',
    messagingSenderId: '952851426705',
    projectId: 'baskonuscevir',
    storageBucket: 'baskonuscevir.appspot.com',
    iosClientId: '952851426705-0m42p57ubecb59h8km8pvp89h2o8uiba.apps.googleusercontent.com',
    iosBundleId: 'com.pdf2.baskonus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcWpqKb9-fOlh7f3Eq3v0u91JEZ_D2dzw',
    appId: '1:952851426705:ios:efca295d1fd28c25bbfe30',
    messagingSenderId: '952851426705',
    projectId: 'baskonuscevir',
    storageBucket: 'baskonuscevir.appspot.com',
    iosClientId: '952851426705-0m42p57ubecb59h8km8pvp89h2o8uiba.apps.googleusercontent.com',
    iosBundleId: 'com.pdf2.baskonus',
  );
}
