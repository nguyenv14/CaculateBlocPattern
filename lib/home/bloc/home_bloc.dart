import 'dart:async';
import 'package:caculatefeebloc/model/user.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository user_repository;
  HomeBloc(this.user_repository) : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToAddUserPageEvent>(homeNavigateToAddUserPageEvent);
    on<HomeGetListEvent>(homeGetListEvent);
    on<UpdatePriceUserEvent>(updatePriceUserEvent);
    on<RemoveUserButtonClick>(removeUserButtonClick);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 1));
    List<UserFee> userFees = user_repository.getListUserFee();
    int price = 0;
    userFees.forEach((element) {
      price = price + element.priceFee;
    });
    emit(HomeLoadedSuccessState(userList: userFees, totalPrice: price));
  }

  FutureOr<void> homeNavigateToAddUserPageEvent(
      HomeNavigateToAddUserPageEvent event, Emitter<HomeState> emit) {
    print("Navigate to Add Page");
    emit(HomeNavigateToAddUserPageState());
  }

  FutureOr<void> homeGetListEvent(
      HomeGetListEvent event, Emitter<HomeState> emit) {
    List<UserFee> userFees = user_repository.getListUserFee();
    int price = 0;
    userFees.forEach((element) {
      price = price + element.priceFee;
    });
    emit(HomeLoadedSuccessState(userList: userFees, totalPrice: price));
  }

  FutureOr<void> updatePriceUserEvent(
      UpdatePriceUserEvent event, Emitter<HomeState> emit) {
    final numericRegex = RegExp(r'^-?[0-9]+$');
    if (!numericRegex.hasMatch(event.price.toString())) {
      emit(HomeUpdatePriceUserErrorState(content: "Vui lòng nhập số!!!"));
    } else {
      user_repository.calculatePrice(int.parse(event.price), event.name);
      emit(HomeUpdatePriceUserSuccessState(
          content: "User " + event.name.toString() + " đã update thành công"));
    }
  }

  FutureOr<void> removeUserButtonClick(
      RemoveUserButtonClick event, Emitter<HomeState> emit) {
    user_repository.deleteUserFee(event.userFee.userName);
    emit(RemoveUserClickSuccessState(
        content: "User " + event.userFee.userName.toString() + " đã xóa!!"));
  }
}
