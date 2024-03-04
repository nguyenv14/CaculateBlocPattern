import 'dart:async';

import 'package:caculatefeebloc/model/spend.dart';
import 'package:caculatefeebloc/repository/spend_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spend_event.dart';
part 'spend_state.dart';

class SpendBloc extends Bloc<SpendEvent, SpendState> {
  final SpendRepository spendRepository;
  SpendBloc(this.spendRepository) : super(SpendInitialState()) {
    on<SpendIntialEvent>(SpendInitialEvent);
    on<SpendGetCurrentEvent>(SpendGetCurrent);
    on<AddPriceToSpendClick>(AddPriceToSpend);
    on<AddPriceToSpendIncomeClick>(AddPriceIncomeClick);
    on<AddPriceToSpendExpenseClick>(AddPriceExpenseClick);
  }

  FutureOr<void> SpendInitialEvent(
      SpendIntialEvent event, Emitter<SpendState> emit) async {
    emit(SpendLoadingState());
    await Future.delayed(Duration(seconds: 2));
    SpendPrice spendPrice = spendRepository.getSpendPriceCurrent();
    // print(spendPrice.id + "   adasad");
    emit(SpendLoadedSuccessState(spend: spendPrice));
  }

  FutureOr<void> SpendGetCurrent(
      SpendGetCurrentEvent event, Emitter<SpendState> emit) {
    SpendPrice spendPrice = spendRepository.getSpendPriceCurrent();
    emit(SpendLoadedSuccessState(spend: spendPrice));
  }

  FutureOr<void> AddPriceToSpend(
      AddPriceToSpendClick event, Emitter<SpendState> emit) {
    print("aaa");
    SpendPrice spendPrice = event.spendPrice;
    spendPrice.expensePrice = spendPrice.expensePrice + event.price;
    bool check = spendRepository.updateSpendPrice(event.spendPrice);
    if (check == true) {
      emit(SpendUpdatePriceSuccessState(
          content: "Đã cập nhật thành công ${event.nameString}!"));
    } else {
      emit(SpendUpdatePriceErrorState(content: "Không tìm thấy id tương ứng!"));
    }
  }

  FutureOr<void> AddPriceIncomeClick(
      AddPriceToSpendIncomeClick event, Emitter<SpendState> emit) {
    SpendPrice spendprice = event.spendPrice;
    spendprice.incomePrice = spendprice.incomePrice + event.price;
    bool check = spendRepository.updateSpendPrice(spendprice);
    if (check == true) {
      emit(SpendUpdatePriceSuccessState(
          content: "Đã cập nhật thành công Income!"));
    } else {
      emit(SpendUpdatePriceErrorState(content: "Không tìm thấy id tương ứng!"));
    }
  }

  FutureOr<void> AddPriceExpenseClick(
      AddPriceToSpendExpenseClick event, Emitter<SpendState> emit) {
    SpendPrice spendprice = event.spendPrice;
    spendprice.expensePrice = spendprice.expensePrice + event.price;
    bool check = spendRepository.updateSpendPrice(spendprice);
    if (check == true) {
      emit(SpendUpdatePriceSuccessState(
          content: "Đã cập nhật thành công Expense!"));
    } else {
      emit(SpendUpdatePriceErrorState(content: "Không tìm thấy id tương ứng!"));
    }
  }
}
