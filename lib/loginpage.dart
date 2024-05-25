// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:nutrilab/authservice.dart';
import 'package:nutrilab/forgot.dart';
import 'package:nutrilab/registerpage.dart';
import './deco.dart';

class GoToLoginPage extends StatefulWidget {
  const GoToLoginPage({super.key});

  @override
  State<GoToLoginPage> createState() => _GoToLoginPageState();
}

class _GoToLoginPageState extends State<GoToLoginPage> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Base font sizes
    final double baseFontSize = screenWidth * 0.05;
    final double smallFontSize = baseFontSize * 0.65;
    final double mediumFontSize = baseFontSize * 0.8;
    final double largeFontSize = baseFontSize*1.4;
    final double extraLargeFontSize = baseFontSize * 2.5;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 226, 209),
      body: Center(
        child: Container(
          width: screenWidth - 40,
          child: Column(
            children: [
              Spacer(
                flex: 16,
              ),
              Stack(
                children: <Widget>[
                  Text(
                    'NUTRILAB',
                    style: TextStyle(
                      fontSize: extraLargeFontSize,
                      fontFamily: 'Genos',
                      fontWeight: FontWeight.w500,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Color.fromARGB(255, 27, 78, 23),
                    ),
                  ),
                  Text(
                    'NUTRILAB',
                    style: TextStyle(
                      fontSize: extraLargeFontSize,
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
                  fontWeight: FontWeight.w700,
                  fontSize: mediumFontSize,
                ),
              ),
              Spacer(flex: 4),
              TextFormField(
                controller: _email,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.w700,
                  fontSize: mediumFontSize,
                ),
                decoration: myDecorationField.copyWith(
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Spacer(),
              TextFormField(
                controller: _password,
                obscureText: true,
                cursorColor: Color.fromARGB(255, 24, 79, 87),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.w700,
                  fontSize: mediumFontSize,
                ),
                decoration: myDecorationField.copyWith(
                  hintText: 'Password',
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gayathri',
                      fontSize: smallFontSize,
                      color: Color.fromARGB(255, 24, 79, 87),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: screenWidth - 40,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontSize: largeFontSize,
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
                    "Not a member?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Gayathri',
                      fontWeight: FontWeight.w700,
                      fontSize: smallFontSize,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: EdgeInsets.all(5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoToRegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 79, 87),
                        fontFamily: 'Gayathri',
                        fontWeight: FontWeight.w700,
                        fontSize: mediumFontSize,
                      ),
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

  _login() async {
    await _auth.loginUserWithEmailAndPassword(
      context,
      _email.text,
      _password.text,
    );
  }
}
