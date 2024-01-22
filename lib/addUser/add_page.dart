import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({super.key});
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AddUserBloc addUserBloc = BlocProvider.of<AddUserBloc>(context);
    return BlocConsumer<AddUserBloc, AddUserPageState>(
      listener: (context, state) {
        if (state is AddUserSuccessStage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Added')));
        }
      },
      bloc: addUserBloc,
      buildWhen: (previous, current) => current is AddUserPageState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: true,
            title: Text("Add User"),
            actions: [
              IconButton(
                  onPressed: () {
                    // homeBloc.add(HomeWishlistButtonNavigateEvent());
                  },
                  icon: Icon(Icons.favorite_border)),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameEditingController,
                  onChanged: (email) {
                    addUserBloc.add(AddUserCheckNameEvent(name: email));
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    errorText: state is CheckValidationFailure
                        ? state.checkName
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: priceEditingController,
                  onChanged: (value) {
                    // authenticationBloc.add(PasswordChanged(password));
                    addUserBloc.add(AddUserCheckPriceEvent(price: value));
                  },
                  decoration: InputDecoration(
                    labelText: 'Price',
                    errorText: state is CheckValidationFailure
                        ? state.checkPrice
                        : null,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // authenticationBloc.add(FormSubmitted());
                    addUserBloc.add(AddUserPageClickSaveUserEvent(
                        username: nameEditingController.text,
                        price: priceEditingController.text));
                  },
                  child: Text('Add User'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
