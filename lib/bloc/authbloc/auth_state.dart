abstract class AuthState {
  String message="";
  String? userId;
  AuthState({required this.message, this.userId});
}

class InitialState extends AuthState {
  InitialState(): super(message:"");
}

class UnauthenticatedState extends AuthState {
  UnauthenticatedState() : super(message:"Successfully logged out!");
}

class LoadingState extends AuthState {
  LoadingState() : super(message:"");
}

class AuthenticatedState extends AuthState {
  AuthenticatedState (String userId): super(message: "Successfully logged in!", userId: userId);   //use this userid to access database in getitems bloc and retrieve or modify liked and cart items
}

class CredinvalidState extends AuthState {
  CredinvalidState() : super(message:"Invalid credentials!");
}

class ErrorState extends AuthState {
  final String error;

  ErrorState(this.error): super(message: error);
}