part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorLoadState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<UserFee> userList;
  HomeLoadedSuccessState({required this.userList});
}

class HomeUpdatePriceUserSuccessState extends HomeActionState {
  final String content;
  HomeUpdatePriceUserSuccessState({required this.content});
}

class HomeUpdatePriceUserErrorState extends HomeActionState {
  final String content;
  HomeUpdatePriceUserErrorState({required this.content});
}

class RemoveUserClickSuccessState extends HomeActionState {
  final String content;
  RemoveUserClickSuccessState({required this.content});
}

class HomeNavigateToAddUserPageState extends HomeActionState {}
