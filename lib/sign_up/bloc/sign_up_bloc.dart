import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/sign_up/service/sign_up_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateUserEvent>((event, emit) async {
      SignUpService signUpService = SignUpService();
      try {
        emit(SignUpLoadingState());
        final user = await signUpService.createNewUser(
            event.fName, event.lName, event.email, event.password);
        emit(SignUpSuccessState(user?.user));
      } catch (e) {
        emit(SignUpErrorState(e.toString()));
      }
    });
  }
}
