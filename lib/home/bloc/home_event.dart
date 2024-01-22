part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeGetListEvent extends HomeEvent {}

class AddUserButtonNavigationClick extends HomeEvent {}

class AddPriceToUserButtonClick extends HomeEvent {
  final UserFee userFee;
  final int price;
  AddPriceToUserButtonClick({
    required this.userFee,
    required this.price,
  });
}

class RemoveUserButtonClick extends HomeEvent {
  final UserFee userFee;
  RemoveUserButtonClick({
    required this.userFee,
  });
}

class UpdatePriceUserEvent extends HomeEvent {
  final String price;
  final int id;
  UpdatePriceUserEvent({required this.price, required this.id});
}

class HomeNavigateToAddUserPageEvent extends HomeEvent {}
