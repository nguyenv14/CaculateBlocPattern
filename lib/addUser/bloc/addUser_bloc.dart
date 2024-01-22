import 'dart:async';
import 'dart:ffi';

import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/model/user.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addUser_event.dart';
part 'addUser_state.dart';

class AddUserBloc extends Bloc<AddUserPageEvent, AddUserPageState> {
  final UserRepository userRepository;
  AddUserBloc(this.userRepository) : super(AddUserInitialStage()) {
    on<AddUserPageClickSaveUserEvent>(saveUserEvent);
    on<AddUserCheckNameEvent>(checkNameEvent);
    on<AddUserCheckPriceEvent>(checkPriceEvent);
  }

  FutureOr<void> saveUserEvent(
      AddUserPageClickSaveUserEvent event, Emitter<AddUserPageState> emit) {
    int price = int.tryParse(event.price) ?? 0;
    String name = event.username;
    userRepository.saveUserFee(name, price);
    emit(AddUserSuccessStage());
    emit(ListenerAddUserSuccess());
  }

  FutureOr<void> checkNameEvent(
      AddUserCheckNameEvent event, Emitter<AddUserPageState> emit) {
    List<UserFee> userFees = userRepository.getListUserFee();
    bool isCheckName =
        userFees.any((element) => element.userName == event.name);
    print(event.name);
    print(isCheckName);
    if (isCheckName) {
      emit(CheckValidationFailure(checkName: "Name is used!"));
    } else {
      emit(CheckValidationFailure());
    }
  }

  FutureOr<void> checkPriceEvent(
      AddUserCheckPriceEvent event, Emitter<AddUserPageState> emit) {
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(event.price)) {
      emit(CheckValidationFailure(checkPrice: "Invalid price!"));
    } else {
      emit(CheckValidationFailure());
    }
  }
}
