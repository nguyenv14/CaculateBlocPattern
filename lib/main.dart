import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/home/home_page.dart';
import 'package:caculatefeebloc/login/login_page.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(UserRepository())),
        BlocProvider(create: (_) => AddUserBloc(UserRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            snackBarTheme: SnackBarThemeData(
              backgroundColor: Colors.teal, // Màu nền của SnackBar
              // contentTextStyle: TextStyle(color: Colors.white), // Màu chữ
              actionTextColor: Colors.yellow, // Màu chữ của action
            ),
            primaryColor: Colors.white),
        home: HomePage(title: "Caculate Debt"),
      ),
    );
  }
}
