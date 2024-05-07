// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './menupage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 79, 162, 177),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              'NUTRILAB',
              style: TextStyle(color: const Color.fromARGB(255, 43, 104, 45), fontSize: 20), 
            ),
            Text(
              'Find the better you', style: TextStyle(color: const Color.fromARGB(255, 47, 112, 49), fontSize: 15
              ),
            )
          ],
        ),
        actions: [IconButton(onPressed: () {
          
        }, icon: Icon(Icons.search,),),],
      ),
    ),
    );
  }
}
