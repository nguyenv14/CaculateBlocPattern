part of 'spend_bloc.dart';

abstract class SpendState {}

abstract class SpendActionState extends SpendState {}

class SpendInitialState extends SpendState {}

class SpendLoadingState extends SpendState {}

class SpendErrorLoadState extends SpendState {}

class SpendLoadedSuccessState extends SpendState {
  final SpendPrice spend;
  SpendLoadedSuccessState({required this.spend});
}

class SpendUpdatePriceSuccessState extends SpendActionState {
  final String content;
  SpendUpdatePriceSuccessState({required this.content});
}

class SpendUpdatePriceErrorState extends SpendActionState {
  final String content;
  SpendUpdatePriceErrorState({required this.content});
}

class SpendNavigateStatistical extends SpendActionState {}
