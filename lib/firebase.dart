import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:solve_ai/firebase_options_dev.dart' as dev;
import 'package:solve_ai/firebase_options_prod.dart' as prod;
import 'package:solve_ai/firebase_options_stg.dart' as stg;

Future<void> initializeFirebaseApp() async {
  /// Determine which Firebase options to use based on the flavor.
  final firebaseOptions = switch (appFlavor) {
    'prod' => prod.DefaultFirebaseOptions.currentPlatform,
    'stg' => stg.DefaultFirebaseOptions.currentPlatform,
    'dev' => dev.DefaultFirebaseOptions.currentPlatform,
    _ => throw UnsupportedError('Invalid flavor: $appFlavor'),
  };

  await Firebase.initializeApp(options: firebaseOptions);
}
