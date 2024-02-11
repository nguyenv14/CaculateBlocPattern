import 'package:caculatefeebloc/home/bloc/home_bloc.dart';
import 'package:caculatefeebloc/model/user.dart';
import 'package:caculatefeebloc/widget_local/yes_no_widget.dart';
import 'package:flutter/material.dart';

class UserFeeItem extends StatelessWidget {
  final UserFee userFee;
  final HomeBloc homeBloc;
  final Color? color;
  UserFeeItem(
      {super.key,
      required this.userFee,
      required this.homeBloc,
      required this.color});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(7, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(userFee.userName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(userFee.dateTime)
            ],
          ),
          SizedBox(
            height: 10,
          ),
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
                      price: textEditingController.text,
                      name: userFee.userName));
                },
                minWidth: 10,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.blueAccent[100],
                textColor: Colors.white,
                child: Icon(
                  Icons.keyboard_backspace,
                  size: 20,
                ),
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
                    width: 20,
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
                      minWidth: 10,
                      height: 50,
                      color: Colors.redAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
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
