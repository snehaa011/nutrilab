// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:nutrilab/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        return FirebaseOptions(
          apiKey: "AIzaSyD-ZsaSJXzN4WzRXn9YGhrOmFUSCV1L604",
          appId: "1:500211632085:android:a839951dda289ebb555f5c",
          messagingSenderId: "500211632085",
          projectId: "my-nutrilab-project",
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyD-ZsaSJXzN4WzRXn9YGhrOmFUSCV1L604",
    appId: "1:500211632085:android:a839951dda289ebb555f5c",
    messagingSenderId: "500211632085",
    projectId: "my-nutrilab-project",
    storageBucket: "my-nutrilab-project.appspot.com",
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
