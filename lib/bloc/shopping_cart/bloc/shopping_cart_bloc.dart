import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_state.dart';
import 'package:yugi_oh_cards/models/data_response.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';
import 'package:yugi_oh_cards/services/firebase_firestore_service.dart';

part 'shopping_cart_event.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartState.initState()) {
    on<ShoppingCartEvent>((event, emit) {});
    on<ShoppingCartBuy>((event, emit) {
      state.orderList = {};
      FireStoreService().updateInfo(event.uid, "orderList", {});
      FireStoreService().updateInfo(event.uid, "favorites", []);
      state.cardsDetails = DataResponse([], "no error");
      emit(ShoppingCartState.loaded(const {}, DataResponse([], "no error")));
    });
    on<ShoppingCartDeleteItem>((event, emit) async {
      DataResponse data =
          await CardApi().fetchId(event.orderList.keys.toList(), tr("lang"));
      event.orderList.remove(event.itemId);
      if (data.error == "no error") {
        emit(ShoppingCartState.loaded(event.orderList, data));
      } else {
        emit(ShoppingCartState.loadError());
      }
    });
    on<ShoppingCartLoad>((event, emit) async {
      emit(ShoppingCartState.loadingState());
      DataResponse data =
          await CardApi().fetchId(event.orderList.keys.toList(), tr("lang"));

      if (data.error == "no error") {
        emit(ShoppingCartState.loaded(event.orderList, data));
      } else {
        emit(ShoppingCartState.loadError());
      }
    });
    on<ShoppingCartChangeItem>((event, emit) async {
      emit(ShoppingCartState.loadingState());
      if (event.isAdd == true) {
        event.orderList[event.itemId.toString()] =
            event.orderList[event.itemId.toString()] + 1;
        FireStoreService().updateInfo(event.uid, "orderList", event.orderList);
      } else {
        if (event.orderList[event.itemId.toString()] > 0) {
          event.orderList[event.itemId.toString()] =
              event.orderList[event.itemId.toString()] - 1;
          FireStoreService()
              .updateInfo(event.uid, "orderList", event.orderList);
        }
      }
      emit(ShoppingCartState.loaded(event.orderList, event.cardsDetails));
    });
  }
}
