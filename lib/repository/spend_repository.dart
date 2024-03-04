import 'package:caculatefeebloc/model/spend.dart';
import 'package:get_storage/get_storage.dart';

class SpendRepository {
  final box = GetStorage();

  SpendPrice getSpendPriceCurrent() {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;
    String formattedDate = '$month/$year';
    List<SpendPrice> list = getListSpend();
    print(list.length);
    if (!list.isEmpty) {
      SpendPrice spendPrice = list.last;
      if (spendPrice.id == formattedDate) {
        return spendPrice;
      } else {
        saveSpendPrice(SpendPrice(
            id: formattedDate,
            incomePrice: 0,
            expensePrice: 0,
            foodPrice: 0,
            goingPrice: 0,
            livePrice: 0,
            studyPrice: 0,
            lovePrice: 0,
            shoppingPrice: 0,
            dateTime: formattedDate));
        List<SpendPrice> list = getListSpend();
        SpendPrice spendPrice = list.last;
        return spendPrice;
      }
    } else {
      saveSpendPrice(SpendPrice(
          id: formattedDate,
          incomePrice: 0,
          expensePrice: 0,
          foodPrice: 0,
          goingPrice: 0,
          livePrice: 0,
          studyPrice: 0,
          lovePrice: 0,
          shoppingPrice: 0,
          dateTime: formattedDate));
      List<SpendPrice> list = getListSpend();
      print("sss: " + list.length.toString());
      SpendPrice spendPrice = SpendPrice(
          id: formattedDate,
          incomePrice: 0,
          expensePrice: 0,
          foodPrice: 0,
          goingPrice: 0,
          livePrice: 0,
          studyPrice: 0,
          lovePrice: 0,
          shoppingPrice: 0,
          dateTime: formattedDate);
      return spendPrice;
    }
  }

  bool updateSpendPrice(SpendPrice spendPriceUpdate) {
    print("update");
    List<SpendPrice> list = getListSpend();
    if (list.last.id == spendPriceUpdate.id) {
      list.last = spendPriceUpdate;
      box.write("SpendCurrent", SpendPrice.getListSpendToJson(list));
      return true;
    }
    return false;
  }

  void saveSpendPrice(SpendPrice spendPrice) {
    List<SpendPrice> list = getListSpend();
    list.add(spendPrice);
    print("Lưu thành công!");
    box.write("SpendCurrent", SpendPrice.getListSpendToJson(list));
  }

  bool deleteSpendPrice(String id) {
    List<SpendPrice> list = getListSpend();
    list.removeWhere(
      (element) => element.id == id,
    );
    return true;
  }

  List<SpendPrice> getListSpend() {
    List<SpendPrice> list =
        SpendPrice.getListSpendPriceFromJson(box.read("SpendCurrent"));
    if (list == null) {
      list = [];
    }
    print("getList");
    return list;
  }
}
