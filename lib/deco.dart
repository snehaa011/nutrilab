// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final myDecorationField = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Email',
  contentPadding: EdgeInsets.all(20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(

    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color.fromARGB(255, 80, 80, 80),
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color.fromARGB(255, 24, 79, 87),
      width: 1.5,
    ),
  ),
  hintStyle: TextStyle(

    color: const Color.fromARGB(255, 87, 87, 87),
    fontFamily: 'Gayathri',
  ),
);
