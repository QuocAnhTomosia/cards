import 'package:equatable/equatable.dart';

import 'package:yugi_oh_cards/services/cards_api_services.dart';

enum ShoppingState { init, loading, loaded, error, buy }

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
  List<Object> get props => [];

  ShoppingCartState.initState()
      : this({}, DataResponse([], 'init'), ShoppingState.init);

  ShoppingCartState.loadingState()
      : this({}, DataResponse([], 'loading'), ShoppingState.loading);
  ShoppingCartState.loaded(
      Map<dynamic, dynamic> orderList, DataResponse cardsDetails)
      : this(orderList, cardsDetails, ShoppingState.loading);
  ShoppingCartState.loadError()
      : this({}, DataResponse([], 'error'), ShoppingState.error);
  ShoppingCartState.loadBuy()
      : this({}, DataResponse([], 'loading'), ShoppingState.buy);
}
