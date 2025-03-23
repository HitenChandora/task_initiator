part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class CreateUserEvent extends SignUpEvent {
  final String fName;
  final String lName;
  final String email;
  final String password;
  CreateUserEvent(this.fName, this.lName, this.email, this.password);
}
