import 'package:flutter/material.dart';
import './navbarwidget.dart';
import './appbarwidget.dart';
import './menu.dart';

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
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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
                'Breakfast',
                style: TextStyle(
                    fontFamily: 'Lalezar',
                    color: const Color.fromARGB(255, 58, 58, 58),
                    fontSize: 20),
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