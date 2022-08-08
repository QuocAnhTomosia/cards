import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';

import 'favorites_state.dart';

part 'favorites_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState.init()) {
    on<FavoritesEvent>((event, emit) {});
    on<FavoritesLoad>((event, emit) async {
   
        emit(FavoritesState.loading());
        DataResponse data = await CardApi().fetchId(event.ids, tr("lang"));
        if (data.list.isNotEmpty) {
          emit(FavoritesState.loaded(event.ids, data));
        } else {
          emit(FavoritesState.error(data));
        }
      
    });
  }
}
