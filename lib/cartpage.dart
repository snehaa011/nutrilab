// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nutrilab/buildcart.dart';

class GoToCartPage extends StatefulWidget {
  const GoToCartPage({super.key});

  @override
  State<GoToCartPage> createState() => _GoToCartPageState();
}

class _GoToCartPageState extends State<GoToCartPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                  'Your Cart',
                  style: TextStyle(
                      color: Color.fromARGB(255, 24, 79, 87),
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lalezar'),
                ),
            ),
          ),
            Expanded(
              child: BuildCart(),
            ),

            
        ],
      )
      );
  }
}