import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/models/data_response.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeSubmit>((event, emit) async {
      emit(HomeState.loadingState());
      Random random = Random();
      List<int> randomList = [];
      for (int i = 0; i < 6; i++) {
        randomList.add(Constant
            .randomNumbers[random.nextInt(Constant.randomNumbers.length)]);
      }
      DataResponse data = await CardApi().fetchId(randomList, tr("lang"));
      if (data.list.isNotEmpty) {
        emit(HomeState.loaded(data));
      } else {
        emit(HomeState.error(data));
      }
    });
  }
}
