import 'package:equatable/equatable.dart';

import 'package:yugi_oh_cards/services/cards_api_services.dart';

enum ShoppingState { init, loading, loaded, error, buy }

// ignore: must_be_immutable
class ShoppingCartState extends Equatable {
  Map<dynamic, dynamic> orderList;
  DataResponse cardsDetails;
  ShoppingState shoppingState;
  ShoppingCartState(
    this.orderList,
    this.cardsDetails,
    this.shoppingState,
  );

  @override
  List<Object> get props => [orderList,cardsDetails,shoppingState];

  ShoppingCartState.initState()
      : this({}, DataResponse([], 'init'), ShoppingState.init);

  ShoppingCartState.loadingState()
      : this({}, DataResponse([], 'loading'), ShoppingState.loading);
  ShoppingCartState.loaded(
      Map<dynamic, dynamic> orderList, DataResponse cardsDetails)
      : this(orderList, cardsDetails, ShoppingState.loaded);
  ShoppingCartState.loadError()
      : this({}, DataResponse([], 'error'), ShoppingState.error);
  ShoppingCartState.loadBuy()
      : this({}, DataResponse([], 'buy'), ShoppingState.buy);
}
