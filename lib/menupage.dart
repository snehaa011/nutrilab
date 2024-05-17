// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nutrilab/buildmenu.dart';

class GoToMenuPage extends StatefulWidget {
  const GoToMenuPage({super.key});

  @override
  State<GoToMenuPage> createState() => _GoToMenuPageState();
}

class _GoToMenuPageState extends State<GoToMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'NUTRILAB',
              style: TextStyle(
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Genos'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              cursorColor: Color.fromARGB(255, 24, 79, 87),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 0.8)),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontFamily: 'Lalezar',
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Breakfast",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),
                        ),                       
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Lunch",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Dinner",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Drinks",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Bites",
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 79, 87),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: MenuPage()),
        ],
      ),
    );
  }
}
