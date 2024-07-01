// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nutrilab/bloc/authbloc/auth_bloc.dart";
import "package:nutrilab/bloc/authbloc/auth_event.dart";
import "package:nutrilab/bloc/authbloc/auth_state.dart";
import "package:nutrilab/navbarwidget.dart";
import "package:nutrilab/snackbar.dart";
import "./deco.dart";

class GoToRegisterPage extends StatelessWidget {
  GoToRegisterPage({super.key});

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  
  Future addUser(String name, email, int mobile) async {
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'name': name,
      'email': email,
      'mobile': mobile,
      'liked': [],
      'cart': {},
      'address': {},
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Base font sizes
    final double baseFontSize = screenWidth * 0.05;
    final double smallFontSize = baseFontSize * 0.65;
    final double mediumFontSize = baseFontSize * 0.8;
    final double largeFontSize = baseFontSize * 1.4;

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
                  fontSize: mediumFontSize,
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
                    fontSize: mediumFontSize),
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
                    fontSize: mediumFontSize),
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
                    fontSize: mediumFontSize),
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
                    fontSize: mediumFontSize),
                decoration: myDecorationField.copyWith(hintText: 'Mobile'),
                keyboardType: TextInputType.number,
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(RegisterClicked(_email.text, _password.text));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(100, 5, 100, 15),
                    backgroundColor: Color.fromARGB(255, 24, 79, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: largeFontSize,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Genos',
                      color: Color.fromARGB(255, 225, 226, 209),
                    ),
                  ),
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.message != "") {
                    if (state is ErrorState){
                      showNotif(context, state.message, duration: 2, error:true);
                    }else{
                      showNotif(context, state.message, duration: 2);
                    }
                  }
                  if (state is AuthenticatedState){
                    addUser(_name.text, _email.text, int.parse(_mobile.text) );
                    goToHome(context);
                  }
                },
                child: Text(""),
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
                        fontSize: smallFontSize),
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
                          fontSize: mediumFontSize),
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

}
