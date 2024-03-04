class SpendPrice {
  String id;
  int incomePrice;
  int expensePrice;
  int foodPrice;
  int goingPrice;
  int studyPrice;
  int shoppingPrice;
  int lovePrice;
  int livePrice;
  String dateTime;

  SpendPrice(
      {required this.id,
      required this.incomePrice,
      required this.expensePrice,
      required this.foodPrice,
      required this.goingPrice,
      required this.livePrice,
      required this.studyPrice,
      required this.lovePrice,
      required this.shoppingPrice,
      required this.dateTime});
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'incomePrice': incomePrice,
      'expensePrice': expensePrice,
      'foodPrice': foodPrice,
      'goingPrice': goingPrice,
      'livePrice': livePrice,
      'studyPrice': studyPrice,
      'lovePrice': lovePrice,
      'shoppingPrice': shoppingPrice,
      'dateTime': dateTime.toString(),
    };
  }

  // Create SpendPrice object from JSON
  factory SpendPrice.fromJson(Map<String, dynamic> json) {
    return SpendPrice(
      id: json['id'].toString(),
      incomePrice: json['incomePrice'],
      expensePrice: json['expensePrice'],
      foodPrice: json['foodPrice'],
      goingPrice: json['goingPrice'],
      livePrice: json['livePrice'],
      studyPrice: json['studyPrice'],
      lovePrice: json['lovePrice'],
      shoppingPrice: json['shoppingPrice'],
      dateTime: json['dateTime'].toString(),
    );
  }
  // SpendPrice(
  //     {required this.incomePrice,
  //     required this.expensePrice,
  //     required this.foodPrice,
  //     required this.goingPrice,
  //     required this.livePrice,
  //     required this.studyPrice,
  //     required this.lovePrice,
  //     required this.shoppingPrice,
  //     required this.dateTime});
  static List<dynamic> getListSpendToJson(List<SpendPrice> spendPrices) {
    List<dynamic> dynamicList = spendPrices.map((e) => e.toJson()).toList();
    return dynamicList;
  }

  // static List<SpendPrice> getListSpendPriceFromJson(
  //     List<dynamic?>? dynamicList) {
  //   if (dynamicList == null) {
  //     return []; // Trả về một danh sách rỗng nếu dynamicList là null
  //   }

  // List<SpendPrice> spendList =
  //     dynamicList.map((e) => SpendPrice.fromJson(e)).toList();
  // return spendList;
  // }
  static List<SpendPrice> getListSpendPriceFromJson(
      List<dynamic?>? dynamicList) {
    print(dynamicList.toString());
    if (dynamicList == null) {
      return [];
    }
    print("1b");
    List<SpendPrice> spendList =
        dynamicList.map((e) => SpendPrice.fromJson(e)).toList();
    print(spendList.length.toString() + "aaa");
    return spendList;
    // return spendList;
  }
}
