// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:yugi_oh_cards/bloc/cards_searching/cards_searching_state.dart';
import 'package:yugi_oh_cards/models/data_response.dart';

import 'package:yugi_oh_cards/services/cards_api_services.dart';

part 'cards_searching_event.dart';

class CardsSearchingBloc
    extends Bloc<CardsSearchingEvent, CardsSearchingState> {
  CardsSearchingBloc() : super(CardsSearchingState.init()) {
    on<CardsSearchingEvent>((event, emit) {});

    on<CardSearchingStarted>((event, emit) async {
      emit(CardsSearchingState.init());
    });

    on<CardSearchingSubmit>((event, emit) async {
      print(event.name);
      emit(CardsSearchingState.loading());
      final DataResponse data =
          await CardApi().fetchData(event.name, event.language);
      if (data.list.isNotEmpty) {
        emit(CardsSearchingState.loaded(data.list));
      } else {
        emit(CardsSearchingState.error(data.error));
      }
    });
  }
}
