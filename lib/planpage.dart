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
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [Container(child:Text("Upgrade your lifestyle with our curated meal plans"))],
          ),
        ),
      );
  }
}
