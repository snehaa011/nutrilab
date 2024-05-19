// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _mobile.dispose();
  }

  Future addUser(String name, email, int mobile) async{
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'name':name,
      'email':email,
      'mobile':mobile,
      'liked':[],
      'cart':{},
      'address':{},
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // Color.fromARGB(255, 250, 240, 222),
      backgroundColor: Color.fromARGB(255, 225, 226, 209),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: [
              Spacer(flex: 16),
              Text(
                "Start an account today!",
                style: TextStyle(
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 4),
              TextFormField(
                controller: _name,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                decoration: myDecorationField.copyWith(hintText: 'Name'),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                controller: _email,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                decoration: myDecorationField.copyWith(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                obscureText: true,
                controller: _password,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                decoration: myDecorationField.copyWith(hintText: 'Password'),
              ),
              Spacer(),
              TextFormField(
                controller: _mobile,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
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
                      color: Color.fromARGB(255, 225, 226, 209),
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
                        fontWeight: FontWeight.w700,
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
                          color: Color.fromARGB(255, 24, 79, 87),
                          fontFamily: 'Gayathri',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
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
      context, MaterialPageRoute(builder: (context) => BottomNav()));

  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(context,_email.text, _password.text);
    if (user != null) {
      log("User Created Successfully");
      addUser(_name.text, _email.text, int.parse(_mobile.text) );
      goToHome(context);
    }
  }
}
