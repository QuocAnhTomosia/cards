
import 'package:dio/dio.dart';
import 'package:yugi_oh_cards/models/card_model.dart';

class CardApi {
  Future<List<YugiOhCard>> fetchData({String name = ""}) async {
    List<YugiOhCard> cards = [];
    if (name == "") {
      return cards;
    }
    try {
      final Response response = await Dio()
          .get("https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=$name");
      response.data["data"]
          .forEach((element) => cards.add(YugiOhCard.fromJson(element)));
      return cards;
    } on DioError {
      rethrow;
    }
  }
}
