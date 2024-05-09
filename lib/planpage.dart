import 'package:flutter/material.dart';
import './navbarwidget.dart';

class GoToPlanPage extends StatefulWidget {
  const GoToPlanPage({super.key});

  @override
  State<GoToPlanPage> createState() => _GoToPlanPageState();
}

class _GoToPlanPageState extends State<GoToPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: Container(
          color: Color.fromARGB(255, 79, 162, 177),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: AppBar(
            
            backgroundColor: Color.fromARGB(255, 79, 162, 177),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NUTRILAB',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos'),
                ),
                Text(
                  'Find the better you',
                  style: TextStyle(
                    color: Color.fromARGB(255, 180, 223, 182),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [Container()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 127, 189, 129),
        child: Icon(Icons.shopping_basket_rounded, color: Colors.white),
      ),
      bottomNavigationBar: buildnavbar(context),
    );
  }
}
