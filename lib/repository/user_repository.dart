import 'package:caculatefeebloc/model/user.dart';
import 'package:get_storage/get_storage.dart';

class UserRepository {
  final box = GetStorage();

  List<UserFee> getListUserFee() {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    return userList;
  }

  void saveUserFee(String userName, int price) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    int size = userList.length;
    UserFee userFee =
        new UserFee(id: size++, userName: userName, priceFee: price);
    userList.add(userFee);
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }

  void deleteUserFee(int id) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    int index = userList.indexWhere((element) => element.id == id);
    userList.removeAt(index);
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }

  void calculatePrice(int price, int id) {
    List<UserFee> userList = UserFee.getListUser(box.read("USER") ?? []);
    int index = userList.indexWhere((element) => element.id == id);
    userList[index].priceFee = userList[index].priceFee + price;
    box.write("USER", UserFee.getListUserFeeJson(userList));
  }
}
