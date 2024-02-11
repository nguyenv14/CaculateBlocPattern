import 'dart:math';

import 'package:caculatefeebloc/addUser/add_page.dart';
import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/home/user_item.dart';
import 'package:caculatefeebloc/repository/until.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // homeBloc = HomeBloc(UserRepository());
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc(UserRepository());

  @override
  Widget build(BuildContext context) {
    // homeBloc ??= HomeBloc(UserRepository());
    return BlocListener<AddUserBloc, AddUserPageState>(
      listener: (context, state) {
        if (state is ListenerAddUserSuccess) {
          homeBloc.add(HomeGetListEvent());
        }
      },
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToAddUserPageState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserPage(),
                ));
          } else if (state is HomeUpdatePriceUserSuccessState) {
            String content = state.content;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(content)));
            homeBloc.add(HomeGetListEvent());
          } else if (state is HomeUpdatePriceUserErrorState) {
            String content = state.content;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(content),
              backgroundColor: Colors.red,
            ));
          } else if (state is RemoveUserClickSuccessState) {
            String content = state.content;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(content)));
            homeBloc.add(HomeGetListEvent());
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Lottie.asset("assets/images/waiting.json"),
                ),
                extendBody: true,
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                  extendBody: true,
                  backgroundColor: Colors.white,
                  body: successState.userList.length != 0
                      ? SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  // height: 00,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hello Nguyen!",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Text(
                                            "How do u feel today?",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                          style: ButtonStyle(
                                              shadowColor: MaterialStateProperty
                                                  .all<Color>(Colors.black),
                                              elevation: MaterialStateProperty
                                                  .all<double>(4.0)),
                                          onPressed: () {},
                                          // selectedIcon: Icon(Icons.abc),
                                          // isSelected: true,
                                          icon: Icon(
                                            Icons.category_outlined,
                                            size: 22,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    infoTotalWidget(
                                        "Users",
                                        successState.userList.length ?? 0,
                                        Colors.pink[300],
                                        Icons.person_pin_circle),
                                    infoTotalWidget(
                                        "Debt",
                                        successState.totalPrice,
                                        Colors.lightBlue[300],
                                        Icons.price_change_rounded)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    "Debt list",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        successState.userList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return UserFeeItem(
                                        homeBloc: homeBloc,
                                        userFee: successState.userList[index],
                                        color: Colors.amber[100],
                                      );
                                    }),
                              ]),
                        )
                      : Center(child: Text("Danh sách rỗng!")),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      homeBloc.add(HomeNavigateToAddUserPageEvent());
                    },
                    child: Icon(Icons.add),
                  ));
            case HomeErrorLoadState:
              return Scaffold(body: Center(child: Text('Error')));
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

Widget infoTotalWidget(
  String title,
  int price,
  Color? color,
  IconData iconData,
) {
  return Container(
    // padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
    width: 175,
    height: 95,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color!.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(5, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white70),
          child: Icon(
            iconData,
            color: color,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(price.toString()),
            )
          ],
        )
      ],
    ),
  );
}
