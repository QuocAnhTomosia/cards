class MyUser {
  String uid;
  String phoneNumber;
  String email;
  String imageLink;
  String password;
  List<int> favorites;
  List<Map<int, int>> orderList;
  MyUser({
    required this.uid,
    required this.phoneNumber,
    required this.email,
    required this.imageLink,
    required this.password,
    required this.favorites,
    required this.orderList,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        uid: json["uid"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        imageLink: json["image_link"],
        favorites: json["favorites"],
        orderList: json["orderList"]);
  }
}
