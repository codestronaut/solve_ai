import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/solve_ai_app.dart';
import 'src/solve_ai_di.dart';

Future<void> runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const SolveAIApp());
}
