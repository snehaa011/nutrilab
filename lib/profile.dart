import 'package:flutter/material.dart';
import 'package:nutrilab/authservice.dart';

class GoToProfile extends StatefulWidget {
  const GoToProfile({super.key});

  @override
  State<GoToProfile> createState() => _GoToProfileState();
}

class _GoToProfileState extends State<GoToProfile> {
  final _auth= AuthService();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton(onPressed: ()async{
        await _auth.signout(context);
      }, child: Text("Sign Out")),
    );
  }
}