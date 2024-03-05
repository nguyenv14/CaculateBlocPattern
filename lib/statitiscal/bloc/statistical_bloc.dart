import 'dart:async';
import 'dart:ffi';

import 'package:caculatefeebloc/model/spend.dart';
import 'package:caculatefeebloc/repository/spend_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'statistical_event.dart';
part 'statistical_state.dart';

class StatisticalBloc extends Bloc {
  final SpendRepository spendRepository;
  StatisticalBloc(this.spendRepository) : super(StatisticalInitalState()) {
    on<StatisticalInitialEvent>(StatisticalInitalEvent);
  }

  FutureOr<void> StatisticalInitalEvent(
      StatisticalInitialEvent event, Emitter emit) {
    List<SpendPrice> list = spendRepository.getListSpend();
    int income = 0;
    int expense = 0;
    list.forEach((element) {
      income = income + element.incomePrice;
      expense = expense + element.expensePrice;
    });
    emit(StatisticalLoadedSuccessState(
        list: list, incomeTotal: income, expenseTotal: expense));
  }
}
