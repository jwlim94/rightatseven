import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rightatseven/emulator_setup.dart';
import 'package:rightatseven/firebase_options.dart';
import 'package:rightatseven/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const useEmulator = true;
  if (useEmulator) {
    await setupFirebaseEmulator();
  }

  // Initialize the app with ProviderScope for Riverpod state management
  runApp(const ProviderScope(child: App()));
}
