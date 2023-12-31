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
    apiKey: 'AIzaSyA35F6rgaVL3_GigfyaoWynQZdJGprEWz4',
    appId: '1:125689548874:web:84ee57bfb91e4cc17e16b3',
    messagingSenderId: '125689548874',
    projectId: 'chat-app-1b177',
    authDomain: 'chat-app-1b177.firebaseapp.com',
    storageBucket: 'chat-app-1b177.appspot.com',
    measurementId: 'G-6VFNXTRFSW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdelSJ26gjGlafnmQQh8pCSsSegciaV80',
    appId: '1:125689548874:android:62cc7b7dec9f445f7e16b3',
    messagingSenderId: '125689548874',
    projectId: 'chat-app-1b177',
    storageBucket: 'chat-app-1b177.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuq3lA1ve-df3Zq67ato0j5b3YgQNyYDw',
    appId: '1:125689548874:ios:d8f944650f066d8b7e16b3',
    messagingSenderId: '125689548874',
    projectId: 'chat-app-1b177',
    storageBucket: 'chat-app-1b177.appspot.com',
    iosClientId: '125689548874-deqdp02l11a9prl60v4c68ldo64e11kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuq3lA1ve-df3Zq67ato0j5b3YgQNyYDw',
    appId: '1:125689548874:ios:d8f944650f066d8b7e16b3',
    messagingSenderId: '125689548874',
    projectId: 'chat-app-1b177',
    storageBucket: 'chat-app-1b177.appspot.com',
    iosClientId: '125689548874-deqdp02l11a9prl60v4c68ldo64e11kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );
}
