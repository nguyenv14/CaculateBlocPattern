import 'package:caculatefeebloc/addUser/add_page.dart';
import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/home/user_item.dart';
import 'package:caculatefeebloc/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  body: Center(
                child: CircularProgressIndicator(),
              ));
              break;
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[100],
                    title: Text("Calculate Price"),
                    actions: [
                      IconButton(
                          onPressed: () {
                            // homeBloc.add(HomeWishlistButtonNavigateEvent());
                          },
                          icon: Icon(Icons.favorite_border)),
                    ],
                  ),
                  body: successState.userList.length != 0
                      ? ListView.builder(
                          itemCount: successState.userList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return UserFeeItem(
                                homeBloc: homeBloc,
                                userFee: successState.userList[index]);
                          })
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
