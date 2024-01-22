part of 'addUser_bloc.dart';

@immutable
abstract class AddUserPageEvent {}

class AddUserPageClickSaveUserEvent extends AddUserPageEvent {
  final String username;
  final String price;
  AddUserPageClickSaveUserEvent({required this.username, required this.price});
}

class AddUserCheckNameEvent extends AddUserPageEvent {
  final String name;
  AddUserCheckNameEvent({required this.name});
}

class AddUserCheckPriceEvent extends AddUserPageEvent {
  final String price;
  AddUserCheckPriceEvent({required this.price});
}
