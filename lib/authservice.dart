import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;
  Future<User?>  createUserWithEmailAndPassword( String email, String password) async{

  }
}