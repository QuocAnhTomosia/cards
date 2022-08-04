part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class ShoppingCartChangeItem extends ShoppingCartEvent {
  final int itemId;
  final bool isAdd;
  Map<int, int> orderList;
  ShoppingCartChangeItem({
    required this.itemId,
    required this.isAdd,
    required this.orderList,
  });

  @override
  List<Object> get props => [itemId, isAdd,orderList];
}

class ShoppingCartDeleteItem extends ShoppingCartEvent {
  final int itemId;
  Map<int, int> orderList;

  ShoppingCartDeleteItem({
    required this.itemId,
    required this.orderList,
  });
  @override
  List<Object> get props => [itemId,orderList];
}

class ShoppingCartBuy extends ShoppingCartEvent {
  const ShoppingCartBuy();
  @override
  List<Object> get props => [];
}
