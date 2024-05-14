// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GoToMenuPage extends StatefulWidget {
  const GoToMenuPage({super.key});

  @override
  State<GoToMenuPage> createState() => _GoToMenuPageState();
}

class _GoToMenuPageState extends State<GoToMenuPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NUTRILAB',
              style: TextStyle(
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Genos'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0.8)),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, size: 30),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontFamily: 'Lalezar',
                    color: const Color.fromARGB(255, 58, 58, 58),
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 40,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Breakfast"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Lunch"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Dinner"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Drinks"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Bites"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      height: 200,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      height: 200,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      height: 200,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
