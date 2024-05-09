import 'package:flutter/material.dart';
import './navbarwidget.dart';
import './appbarwidget.dart';

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
      appBar: AppW(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [Container(child:Text("hello"))],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 127, 189, 129),
        child: Icon(Icons.shopping_basket_rounded, color: Colors.white),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
