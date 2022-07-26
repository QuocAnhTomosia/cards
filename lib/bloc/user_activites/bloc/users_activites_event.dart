part of 'users_activites_bloc.dart';

abstract class UsersActivitesEvent extends Equatable {
  const UsersActivitesEvent();

  @override
  List<Object> get props => [];
}

class UserChangeInfo extends UsersActivitesEvent {
  final SignUpInfo info;
  const UserChangeInfo(this.info);
  @override
  List<Object> get props => [info];
}

class UserLogOut extends UserActivitiesEvent {
  final bool isLogin;
  const UserLogOut(this.isLogin);
  @override
  List<Object> get props => [isLogin];
}

class UserChangeFavorites extends UsersActivitesEvent {
  const UserChangeFavorites();
  @override
  List<Object> get props => [];
}

class UserChangeBuyList extends UsersActivitesEvent {
  const UserChangeBuyList();
  @override
  List<Object> get props => [];
}

class UserBuy extends UsersActivitesEvent {
  const UserBuy();
  @override
  List<Object> get props => [];
}
