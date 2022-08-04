import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_state.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';

part 'shopping_cart_event.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartState.initState()) {
    on<ShoppingCartEvent>((event, emit) {});
    on<ShoppingCartBuy>((event, emit) {});
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
    on<ShoppingCartChangeItem>((event, emit) async {
      emit(ShoppingCartState.loadingState());
      DataResponse data =
          await CardApi().fetchId(event.orderList.keys.toList(), tr("lang"));
      if (event.isAdd == true) {
        event.orderList[event.itemId] = event.orderList[event.itemId]! + 1;
      } else {
        if (event.orderList[event.itemId]! > 0) {
          event.orderList[event.itemId] = event.orderList[event.itemId]! - 1;
        }
      }
      if (data.error == "no error") {
        emit(ShoppingCartState.loaded(event.orderList, data));
      } else {
        emit(ShoppingCartState.loadError());
      }
    });
  }
}
