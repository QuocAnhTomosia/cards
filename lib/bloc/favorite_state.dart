part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}
