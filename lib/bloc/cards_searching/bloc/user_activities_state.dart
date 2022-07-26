part of 'user_activities_bloc.dart';

abstract class UserActivitiesState extends Equatable {
  const UserActivitiesState();
  
  @override
  List<Object> get props => [];
}

class UserActivitiesInitial extends UserActivitiesState {}
