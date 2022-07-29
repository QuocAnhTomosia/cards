part of 'user_activites_bloc.dart';

abstract class UserActivitesState extends Equatable {
  const UserActivitesState();
  
  @override
  List<Object> get props => [];
}

class UserActivitesInitial extends UserActivitesState {}
