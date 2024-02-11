abstract class LoginPageEvent {}

// class LoginPageInitialEvent extends LoginPageEvent {}

class LoginPageClickLoginEvent extends LoginPageEvent {
  final String pass;
  LoginPageClickLoginEvent({required this.pass});
}
