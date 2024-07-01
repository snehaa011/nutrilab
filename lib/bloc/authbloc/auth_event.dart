abstract class AuthEvent {}

class RegisterClicked extends AuthEvent {
  final String email;
  final String password;

  RegisterClicked(this.email, this.password);
}

class LoginClicked extends AuthEvent {
  final String email;
  final String password;

  LoginClicked(this.email, this.password);
}

class LogoutClicked extends AuthEvent {}