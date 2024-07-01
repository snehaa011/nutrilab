import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilab/bloc/authbloc/auth_event.dart';
import 'package:nutrilab/bloc/authbloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final _auth = FirebaseAuth.instance;

    AuthBloc(): super(InitialState()){
      on <RegisterClicked> (_signup);
      on <LoginClicked> (_login);
      on <LogoutClicked> (_logout);
    }

    Future <void> _signup ( RegisterClicked event, Emitter <AuthState> emit) async {
       try {
      await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      User? user=_auth.currentUser;
      if (user == null ){
        emit(ErrorState('Unknown error occurred.'));
      } 
      else{
        emit(AuthenticatedState( user.email ?? ""));
      }
      
    } catch (e) {
      emit(ErrorState('$e'));
    }
}

  Future <void> _login (LoginClicked event, Emitter<AuthState> emit) async {
    try{
      await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      User? user=_auth.currentUser;
      if (user == null ){
        emit(ErrorState('Unknown error occurred.'));
      } 
      else{
        emit(AuthenticatedState( user.email ?? ""));
      }
    } catch(e){
      emit(CredinvalidState());
    }
  }

  Future <void> _logout (LogoutClicked event, Emitter <AuthState> emit) async {
    try{
      await _auth.signOut();
      emit(UnauthenticatedState());
    }catch (e){
      emit(ErrorState('$e'));
    }
  }
}