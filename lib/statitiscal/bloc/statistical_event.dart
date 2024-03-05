part of 'statistical_bloc.dart';

@immutable
abstract class StatisticalEvent {}

class StatisticalInitialEvent extends StatisticalEvent {}

class StatisticalGetListSpendEvent extends StatisticalEvent {}
