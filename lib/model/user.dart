class UserFee {
  int id;
  String userName;
  String dateTime;
  int priceFee;

  UserFee(
      {required this.id,
      required this.userName,
      required this.dateTime,
      required this.priceFee});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'dateTime': dateTime,
      'priceFee': priceFee,
    };
  }

  factory UserFee.fromJson(Map<String, dynamic> json) {
    return UserFee(
      id: json['id'],
      userName: json['userName'],
      dateTime: json['dateTime'],
      priceFee: json['priceFee'],
    );
  }

  static List<dynamic> getListUserFeeJson(List<UserFee> userFees) {
    List<dynamic> dynamicList = userFees.map((e) => e.toJson()).toList();
    return dynamicList;
  }

  static List<UserFee> getListUser(List<dynamic> dynamicList) {
    List<UserFee> userList =
        dynamicList.map((e) => UserFee.fromJson(e)).toList();
    return userList;
  }
}
