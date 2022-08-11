import 'dart:math';

import 'package:dio/dio.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/models/card_model.dart';
import 'package:yugi_oh_cards/models/data_response.dart';

class CardApi {
  Future<DataResponse> fetchId(List<dynamic> ids, String language) async {
    List<YugiOhCard> cards = [];
    try {
      var options = BaseOptions(
        baseUrl: Constant.baseUrl,
        receiveTimeout: 10000, //
        connectTimeout: 10000,
        sendTimeout: 10000,
      );
      String idsString = ids
          .toString()
          .replaceAll(' ', '')
          .replaceAll('[', '')
          .replaceAll(']', '');
      final Response response = await Dio(options).get(
          "id=  $idsString${language == "en" ? "" : "&language=$language"}");
      if (response.data["data"] != []) {
        response.data["data"]
            .forEach((element) => cards.add(YugiOhCard.fromJsonApi(element)));
      }
      return DataResponse(cards, "no error");
    } on DioError catch (e) {
      return DataResponse([], handleDioError(e));
    }
  }

  Future<DataResponse> fetchType(String type, String language) async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    List<YugiOhCard> cards = [];
    try {
      final Response response = await Dio(Constant.baseOption).get(
        "type=$type${language == "en" ? "" : "&language=$language"}"
        "&offset=$randomNumber"
        "&num=20",
      );
      if (response.data["data"] != []) {
        response.data["data"]
            .forEach((element) => cards.add(YugiOhCard.fromJsonApi(element)));
      }
      return DataResponse(cards, "no error");
    } on DioError catch (e) {
      return DataResponse([], handleDioError(e));
    }
  }

  Future<DataResponse> fetchData(String name, String language) async {
    List<YugiOhCard> cards = [];
    if (name == "") {
      try {
        final Response response = await Dio().get(
          "https://db.ygoprodeck.com/api/v7/randomcard.php",
        );
        if (response.data != {}) {
          cards.add(YugiOhCard.fromJsonApi(response.data));
        }
        return DataResponse(cards, "no error");
      } on DioError catch (e) {
        return DataResponse([], handleDioError(e));
      }
    } else {
      try {
        final Response response = await Dio(Constant.baseOption).get(
          "fname=$name${language == "en" ? "" : "&language=$language"}",
        );
        if (response.data["data"] != []) {
          response.data["data"]
              .forEach((element) => cards.add(YugiOhCard.fromJsonApi(element)));
        }
        return DataResponse(cards, "no error");
      } on DioError catch (e) {
        return DataResponse([], handleDioError(e));
      }
    }
  }

  handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.cancel:
        return "Your request is canceled";
      case DioErrorType.connectTimeout:
        return "cant not connect to url";
      case DioErrorType.sendTimeout:
        return "sent Timeout";
      case DioErrorType.receiveTimeout:
        return "Received Timeout";
      case DioErrorType.response:
        return e.response!.data["error"].toString();
      case DioErrorType.other:
        return "Unkown Error";
    }
  }
}
