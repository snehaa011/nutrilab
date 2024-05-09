// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nutrilab/menupage.dart';
import 'package:nutrilab/planpage.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int myIndex=0;
  List<Widget> pages=[
    GoToMenuPage(),
    GoToPlanPage(),
    GoToMenuPage(),
    GoToPlanPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      body: pages[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 253, 253, 253),
        unselectedItemColor: Colors.white,
        iconSize: 35,
        backgroundColor: Color.fromARGB(255, 24, 79, 87),
        onTap: (index) {
          setState(() {
            myIndex=index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_dining,
              // color: Colors.white,
              // size: 30,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
              // color: Colors.white,
              size: 30,
            ),
            label: 'Mealplans',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
              // color: Colors.white,
              size: 30,
            ),
            label: 'Cookbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_sharp,
              // color: Colors.white,
              size: 30,
            ),
            label:'Profile',
          ),
        ],
      
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20),
        //       topRight: Radius.circular(20),
        //     ),
        //     color: Color.fromARGB(255, 24, 79, 87),
        //   ),
        // ),
      ),
    );
  }
}
