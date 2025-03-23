part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final String? message;
  SignInSuccessState(this.message);
}

class SignInErrorState extends SignInState {
  final String message;
  SignInErrorState(this.message);
}
