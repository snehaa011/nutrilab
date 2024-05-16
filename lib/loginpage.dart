// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrilab/authservice.dart';
import 'package:nutrilab/registerpage.dart';
import './deco.dart';
import './navbarwidget.dart';

class GoToLoginPage extends StatefulWidget {
  const GoToLoginPage({super.key});

  @override
  State<GoToLoginPage> createState() => _GoToLoginPageState();
}

class _GoToLoginPageState extends State<GoToLoginPage> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password =TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 240, 222),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: [
              Spacer(
                flex: 16,
              ),
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'NUTRILAB',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Genos',
                      fontWeight: FontWeight.w500,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Color.fromARGB(255, 27, 78, 23),
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'NUTRILAB',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos',
                      color: Color.fromARGB(255, 122, 185, 120),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2),
              Text(
                "Welcome back, you have been missed!",
                style: TextStyle(
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Spacer(flex: 4),
              TextFormField(
                controller: _email,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(
                  hintText: 'Email'
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                controller: _password,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Gayathri'),
                decoration: myDecorationField.copyWith(
                  hintText: 'Password'
                ),
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    "SIGN IN",
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
                    "Not a member?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Gayathri',
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: EdgeInsets.all(5)
                    ),
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GoToRegisterPage(),),); },
                    child: Text(
                      "Register Now",
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

  _login() async{
    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user!=null){
      log("User Logged In");
      goToHome(context);
    }
  }
}
