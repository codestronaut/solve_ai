import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/solve_ai_app.dart';
import 'src/solve_ai_di.dart';

Future<void> runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(record.message, name: '${record.level.name}: ${record.time}');
  });

  await Firebase.initializeApp(options: firebaseOptions);
  await clearUserOnFirstInstall();
  runApp(const SolveAIApp());
}

Future<void> clearUserOnFirstInstall() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.get('app-fresh-install') == null) {
    await prefs.setBool('app-fresh-install', true);
    await FirebaseAuth.instance.signOut();
  }
}
