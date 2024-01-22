part of 'addUser_bloc.dart';

@immutable
abstract class AddUserPageState {}

class AddUserInitialStage extends AddUserPageState {}

class AddUserErrorStage extends AddUserPageState {}

class AddUserSuccessStage extends AddUserPageState {}

class CheckValidationFailure extends AddUserPageState {
  final String? checkName;
  final String? checkPrice;
  CheckValidationFailure({this.checkName, this.checkPrice});
}

class ListenerAddUserSuccess extends AddUserPageState {}

// class AddUser