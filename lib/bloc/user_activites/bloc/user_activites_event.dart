part of 'user_activites_bloc.dart';

abstract class UserActivitesEvent extends Equatable {
  const UserActivitesEvent();

  @override
  List<Object> get props => [];
}

class UserChangeFavorites extends UserActivitesEvent {
  // bool isAdd;
  // int cardId;
}

class UserChangeOrders extends UserActivitesEvent {
  // int cardId;
  // int amount;
}

class UserChangeInfo extends UserActivitesEvent {

}
