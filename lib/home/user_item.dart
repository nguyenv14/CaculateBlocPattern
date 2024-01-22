import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/model/user.dart';
import 'package:caculatefeebloc/widget_local/yes_no_widget.dart';
import 'package:flutter/material.dart';

class UserFeeItem extends StatelessWidget {
  final UserFee userFee;
  final HomeBloc homeBloc;
  UserFeeItem({super.key, required this.userFee, required this.homeBloc});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(userFee.userName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                child: Text("" + userFee.priceFee.toString() + "K",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400])),
              ),
              MaterialButton(
                onPressed: () {
                  print(textEditingController.text);
                  homeBloc.add(UpdatePriceUserEvent(
                      price: textEditingController.text, id: userFee.id));
                },
                // minWidth: 100,
                // color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blueAccent[100],
                textColor: Colors.white,
                child: Icon(Icons.keyboard_backspace),
              ),
              Row(
                children: [
                  Container(
                    width: 70,
                    child: TextField(
                      style: TextStyle(),
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return YesNoDialog(
                              title: "Thông báo",
                              content: "Bạn có chắc chắn xóa user này không?",
                              onYesPressed: () {
                                Navigator.of(context).pop();
                                homeBloc.add(
                                    RemoveUserButtonClick(userFee: userFee));
                              },
                              onNoPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                      // style: ButtonStyle(),
                      minWidth: 40,
                      color: Colors.redAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
