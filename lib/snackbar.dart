import 'package:flutter/material.dart';

void showNotif(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, style: TextStyle(color: Colors.white),),
    duration: Duration(seconds: 2), // Adjust the duration as needed
    backgroundColor: Color.fromARGB(255, 58, 58, 58),
    margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Find the nearest ScaffoldMessenger to show the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}