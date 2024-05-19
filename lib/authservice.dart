import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrilab/snackbar.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<User?> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      showNotif(context,"Error: $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      showNotif(context,"Error: $e");
    }
    return null;
  }

  Future <void> signout(BuildContext context) async{
    try{
      await _auth.signOut();
    }catch(e){
      showNotif(context,"Error: $e");
    }
  }
}
