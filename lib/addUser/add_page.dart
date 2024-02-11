import 'package:caculatefeebloc/addUser/bloc/addUser_bloc.dart';
import 'package:caculatefeebloc/home/home_page.dart';
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_sharp)),
                    Text(
                      "Add debt user",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: nameEditingController,
                    onChanged: (email) {
                      addUserBloc.add(AddUserCheckNameEvent(name: email));
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_2_outlined),
                      errorText: state is CheckValidationFailure
                          ? state.checkName
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 20.0),
                TextField(
                  controller: priceEditingController,
                  onChanged: (value) {
                    addUserBloc.add(AddUserCheckPriceEvent(price: value));
                  },
                  decoration: InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.price_change_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    errorText: state is CheckValidationFailure
                        ? state.checkPrice
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                OutlinedButton(
                    onPressed: () {
                      if (nameEditingController.text != "" &&
                          priceEditingController.text != "") {
                        addUserBloc.add(AddUserPageClickSaveUserEvent(
                            username: nameEditingController.text,
                            price: priceEditingController.text));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Vui lòng nhập đủ thông tin!")));
                      }
                    },
                    child: const Text('Add user'),
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.blue)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.blue[200]!),
                        elevation: MaterialStateProperty.all<double>(5.0))),
                // MaterialButton(
                //   onPressed: () {
                //     // authenticationBloc.add(FormSubmitted());

                //   },
                //   child: Text('Add User'),
                //   shape: ShapeBorder,
                //   // style: ButtonStyle(
                //   //     backgroundColor:
                //   //         MaterialStateProperty.all<Color>(Colors.white),
                //   //     shadowColor: MaterialStateProperty.all<Color>(Colors.red),
                //   //     elevation: MaterialStateProperty.all<double>(7.0),
                //   //     side: ,
                //   //     overlayColor:
                //   //         MaterialStateProperty.all<Color>(Colors.black),
                //   //     foregroundColor:
                //   //         MaterialStateProperty.all<Color>(Colors.red)),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
