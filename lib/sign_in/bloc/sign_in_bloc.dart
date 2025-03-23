import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../service/sign_in_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInUserEvent>((event, emit) async {
      SignInService signInService = SignInService();
      try {
        emit(SignInLoadingState());
        final message = await signInService.SignIn(event.email, event.password);
        if (message == "Success") {
          emit(SignInSuccessState(message));
        } else {
          emit(SignInErrorState("Something went wrong"));
        }
      } catch (e) {
        emit(SignInErrorState(e.toString()));
      }
    });
  }
}
