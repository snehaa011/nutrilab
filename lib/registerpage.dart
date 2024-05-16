// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:nutrilab/authservice.dart";
import 'dart:developer';
import "package:nutrilab/navbarwidget.dart";
import "./deco.dart";

class GoToRegisterPage extends StatefulWidget {
  const GoToRegisterPage({super.key});

  @override
  State<GoToRegisterPage> createState() => _GoToRegisterPageState();
}

class _GoToRegisterPageState extends State<GoToRegisterPage> {
  final _auth= AuthService();
  final _name= TextEditingController();
  final _email= TextEditingController();
  final _password= TextEditingController();
  final _mobile= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 240, 222),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: [
              Spacer(flex: 16),
              Text(
                "Start an account today",
                style: TextStyle(
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 4),
              TextFormField(
                controller: _name,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(hintText: 'Name'),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                controller: _email,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                controller: _password,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(hintText: 'Password'),
              ),
              Spacer(),
              TextFormField(
                controller: _mobile,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(hintText: 'Mobile'),
                keyboardType: TextInputType.number,
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: _signup,
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos',
                      color: Color.fromARGB(255, 250, 240, 222),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(100, 5, 100, 15),
                    backgroundColor: Color.fromARGB(255, 24, 79, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I am a member?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Gayathri',
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        padding: EdgeInsets.all(5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign in Now",
                      style: TextStyle(
                          color: Color.fromARGB(255, 122, 185, 120),
                          fontFamily: 'Gayathri',
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 16),
            ],
          ),
        ),
      ),
    );
  }
  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BottomNav())
  );

  _signup() async{
    final user= await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user !=null){
      log("User Created Successfully");
      goToHome(context);
    }
  }
}