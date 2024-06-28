// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/authbloc/auth_bloc.dart';
import 'package:nutrilab/bloc/authbloc/auth_state.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/menubloc/menu_bloc.dart';
import 'package:nutrilab/cartpage.dart';
import 'package:nutrilab/menupage.dart';
import 'package:nutrilab/profile.dart';
import 'package:nutrilab/savedpage.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int myIndex=0;
  
  List<Widget> pages=[
    GoToMenuPage(),
    GoToSavedPage(),
    GoToCartPage(),
    GoToProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    String id= context.watch<AuthBloc>().state.userId ?? "";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 226, 209),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GetItemsBloc(id)),
            BlocProvider(create: (context) => MenuBloc())
          ],
          child: pages[myIndex]
        ),
            
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
                Icons.favorite_border_outlined,
                // color: Colors.white,
                size: 30,
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
                // color: Colors.white,
                size: 30,
              ),
              label: 'Cart',
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
        ),
      ),
    );
  }
}
