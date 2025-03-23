part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final User? user;
  SignUpSuccessState(this.user);
}

class SignUpErrorState extends SignUpState {
  final String message;
  SignUpErrorState(this.message);
}
