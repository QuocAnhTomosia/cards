import 'card_model.dart';

class DataResponse {
  final List<YugiOhCard> list;
  final String error;

  DataResponse(this.list, this.error);
  get data => list;
}
