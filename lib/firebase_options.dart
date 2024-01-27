// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDXFmgAG6G-MhTeMGgbgB6jiz7e4KdSYK8',
    appId: '1:202920770583:android:5d4f17573a6e7be6a7b052',
    messagingSenderId: '202920770583',
    projectId: 'arvapp-5dcfc',
    storageBucket: 'arvapp-5dcfc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2qDYFKS9IICbRCBwstQz5g3TSEz_RU8I',
    appId: '1:202920770583:ios:f8abb985576a65e4a7b052',
    messagingSenderId: '202920770583',
    projectId: 'arvapp-5dcfc',
    storageBucket: 'arvapp-5dcfc.appspot.com',
    androidClientId:
        '202920770583-ld3ppabhbeehb2qki2b31enkicgsfnc7.apps.googleusercontent.com',
    iosClientId:
        '202920770583-l9fjfso1ndimbk1o3mhm2umeamjbh7bn.apps.googleusercontent.com',
    iosBundleId: 'com.arv.app.arv',
  );
}
