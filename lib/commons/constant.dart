import 'package:yugi_oh_cards/models/user_model.dart';

class Constant {
  String avatarImage ="assets/images/avatar.png";
  MyUser errorUser = MyUser(
      uid: "err",
      phoneNumber: "err",
      email: "err",
      imageLink: "err",
      password: "err",
      favorites: [],
      orderList: [
        {0: 0}
      ]);
}
