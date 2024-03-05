import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/home/home_page.dart';
import 'package:caculatefeebloc/login/login_page.dart';
import 'package:caculatefeebloc/repository/spend_repository.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:caculatefeebloc/spend/bloc/spend_bloc.dart';
import 'package:caculatefeebloc/spend/spend_page.dart';
import 'package:caculatefeebloc/statitiscal/bloc/statistical_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
        BlocProvider(create: (_) => SpendBloc(SpendRepository())),
        BlocProvider(create: (_) => StatisticalBloc(SpendRepository()))
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
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> _pages = [HomePage(title: "Caculate Debt"), SpendPage()];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.handHoldingDollar),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.moneyCheckDollar),
              title: Text("Spend"),
              selectedColor: Colors.pink,
            ),
          ]),
      body: IndexedStack(
        children: _pages,
        index: currentIndex,
      ),
    );
  }
}
