import 'package:caculatefeebloc/home/home_page.dart';
import 'package:caculatefeebloc/login/bloc/login_bloc.dart';
import 'package:caculatefeebloc/login/bloc/login_event.dart';
import 'package:caculatefeebloc/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController textEditingController = TextEditingController();
  final LoginPageBloc loginPageBloc = LoginPageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginPageBloc,
      listener: (context, state) {
        if (state is LoginPageErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Sai mật khẩu. Vui lòng nhập lại!!")));
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(title: "Caculate Debt"),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Vui lòng nhập mật khẩu!",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                loginPageBloc.add(
                    LoginPageClickLoginEvent(pass: textEditingController.text));
              },
              color: Colors.blue[100],
              child: Icon(Icons.login),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )
          ]),
        ),
      ),
    );
  }
}
