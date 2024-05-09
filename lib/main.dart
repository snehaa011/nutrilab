// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nutrilab/appbarwidget.dart';
import 'package:nutrilab/navbarwidget.dart';
import './menupage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _folded = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 226, 226),
        appBar: AppW(
          widgets: [
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: _folded ? 40 : 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: kElevationToShadow[3],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: _folded
                            ? null
                            : TextField(
                                decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 35, 58, 33),
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none),
                              ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 400,
                      ),
                      child: InkWell(
                        child: Icon(
                          Icons.search,
                          color: const Color.fromARGB(255, 63, 109, 64),
                        ),
                        onTap: () {
                          setState(() {
                            _folded = !_folded;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Menu(),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 127, 189, 129),
          child: Icon(Icons.shopping_basket_rounded, color: Colors.white),
        ),
        bottomNavigationBar: buildnavbar(context),
      ),
    );
  }
}
