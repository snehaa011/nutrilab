import 'package:flutter/material.dart';
import 'package:nutrilab/planpage.dart';

Widget buildnavbar(BuildContext context) {
  return BottomAppBar(
    color: Color.fromARGB(255, 226, 226, 226),
    padding: EdgeInsets.all(0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color.fromARGB(255, 24, 79, 87),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.local_dining,
              color: Colors.white,
              size: 30,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoToPlanPage(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 30,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_book_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_sharp,
              color: Colors.white,
              size: 30,
            ),
          ),
          Spacer(),
        ],
      ),
    ),
  );
}
