part of 'spend_bloc.dart';

@immutable
abstract class SpendEvent {}

class SpendIntialEvent extends SpendEvent {}

class SpendGetCurrentEvent extends SpendEvent {}

class AddPriceToSpendClick extends SpendEvent {
  final SpendPrice spendPrice;
  final String nameString;
  final int price;
  AddPriceToSpendClick(
      {required this.spendPrice,
      required this.nameString,
      required this.price});
}

class AddPriceToSpendIncomeClick extends SpendEvent {
  final SpendPrice spendPrice;
  final int price;
  AddPriceToSpendIncomeClick({required this.spendPrice, required this.price});
}

class AddPriceToSpendExpenseClick extends SpendEvent {
  final SpendPrice spendPrice;
  final int price;
  AddPriceToSpendExpenseClick({required this.spendPrice, required this.price});
}

class SpendPageNavigateToStatisticalPageEvent extends SpendEvent {}
