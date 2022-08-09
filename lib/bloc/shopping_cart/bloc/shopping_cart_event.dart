part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ShoppingCartChangeItem extends ShoppingCartEvent {
  final int itemId;
  final bool isAdd;
  Map<dynamic, dynamic> orderList;
  DataResponse cardsDetails;
  String uid;
  ShoppingCartChangeItem({
    required this.itemId,
    required this.isAdd,
    required this.orderList,
    required this.cardsDetails,
    required this.uid,
  });

  @override
  List<Object> get props => [itemId, isAdd, orderList, uid, cardsDetails];
}

// ignore: must_be_immutable
class ShoppingCartDeleteItem extends ShoppingCartEvent {
  final int itemId;
  Map<int, int> orderList;

  ShoppingCartDeleteItem({
    required this.itemId,
    required this.orderList,
  });
  @override
  List<Object> get props => [itemId, orderList];
}

class ShoppingCartBuy extends ShoppingCartEvent {
  final String uid;

  const ShoppingCartBuy({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

// ignore: must_be_immutable
class ShoppingCartLoad extends ShoppingCartEvent {
  Map<dynamic, dynamic> orderList;
  ShoppingCartLoad(
    this.orderList,
  );
  @override
  List<Object> get props => [];
}
