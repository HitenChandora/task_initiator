part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInUserEvent extends SignInEvent {
  final String email;
  final String password;
  SignInUserEvent(this.email, this.password);
}
