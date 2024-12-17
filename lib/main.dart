import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solve_ai/src/solve_ai_app.dart';

Future<void> runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const SolveAIApp());
}
