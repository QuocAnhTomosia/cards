import 'package:equatable/equatable.dart';

import 'package:yugi_oh_cards/models/card_model.dart';

enum CardSearchStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class CardsSearchingState extends Equatable {
  List<YugiOhCard> data;
  CardSearchStatus status;
  String response;

  CardsSearchingState({
    required this.status,
    required this.data,
    required this.response,
  });

  CardsSearchingState.init()
      : this(data: [], response: "init", status: CardSearchStatus.init);
  CardsSearchingState.loading()
      : this(data: [], response: "loading", status: CardSearchStatus.loading);
  CardsSearchingState.loaded(
    List<YugiOhCard> data,
  ) : this(data: data, response: "loaded", status: CardSearchStatus.loaded);
  CardsSearchingState.error(String response)
      : this(data: [], response: response, status: CardSearchStatus.error);
  @override
  List<Object> get props => [data, response];
}
