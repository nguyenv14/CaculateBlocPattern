part of 'statistical_bloc.dart';

abstract class StatisticalState {}

class StatisticalInitalState extends StatisticalState {}

class StatisticalLoadingState extends StatisticalState {}

class StatisticalLoadedSuccessState extends StatisticalState {
  final List<SpendPrice> list;
  final int incomeTotal;
  final int expenseTotal;
  StatisticalLoadedSuccessState(
      {required this.list,
      required this.incomeTotal,
      required this.expenseTotal});
}

class StatisticalLoadedErrorState extends StatisticalState {}
