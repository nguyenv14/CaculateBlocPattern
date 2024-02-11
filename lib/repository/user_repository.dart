import 'package:caculatefeebloc/model/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class UserRepository {
  final box = GetStorage();

  List<UserFee> getListUserFee() {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    return userList;
  }

  void saveUserFee(String userName, int price) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    int size = userList.length;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDateTime = formatter.format(now);
    UserFee userFee = new UserFee(
        id: size++,
        userName: userName,
        dateTime: formattedDateTime,
        priceFee: price);
    userList.add(userFee);
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }

  void deleteUserFee(String name) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    int index = userList.indexWhere((element) => element.userName == name);
    userList.removeAt(index);
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }

  void calculatePrice(int price, String id) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDateTime = formatter.format(now);
    int index = userList.indexWhere((element) => element.userName == id);
    userList[index].priceFee = userList[index].priceFee + price;
    userList[index].dateTime = formattedDateTime;
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }
}
