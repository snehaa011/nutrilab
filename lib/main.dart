// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrilab/loginpage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //       apiKey: "AIzaSyD-ZsaSJXzN4WzRXn9YGhrOmFUSCV1L604",
  //       authDomain: "my-nutrilab-project.firebaseapp.com",
  //       projectId: "my-nutrilab-project",
  //       storageBucket: "my-nutrilab-project.appspot.com",
  //       messagingSenderId: "500211632085",
  //       appId: "1:500211632085:android:a839951dda289ebb555f5c"),
  // );

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoToLoginPage(),
    );
  }
}
