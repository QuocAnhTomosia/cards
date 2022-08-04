import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';

import '../../../commons/constant.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeSubmit>((event, emit) async {
      if (state.statusCode == StatusCode.init) {
        emit(HomeState.loadingState());
         Random random = new Random();
        List<int> randomList = [];
        for (int i = 0; i < 6; i++) {
          randomList.add(Constant()
              .randomNumbers[random.nextInt(Constant().randomNumbers.length)]);
        }
        DataResponse data = await CardApi().fetchId(randomList, tr("lang"));
          if (data.list.isNotEmpty) {
          print("length of data${data.list.length}");
          emit(HomeState.loaded(data));
        } else {
          emit(HomeState.error(data));
        }
      }
    });
  }
}
