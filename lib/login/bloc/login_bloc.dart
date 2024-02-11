import 'dart:async';

import 'package:caculatefeebloc/login/bloc/login_event.dart';
import 'package:caculatefeebloc/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitialStage()) {
    on<LoginPageClickLoginEvent>(loginPageEvent);
  }

  FutureOr<void> loginPageEvent(
      LoginPageClickLoginEvent event, Emitter<LoginPageState> emit) {
    String pass = event.pass;
    if (pass == "nguyenv14") {
      emit(LoginPageSuccessState());
    } else {
      emit(LoginPageErrorState());
    }
  }
}
