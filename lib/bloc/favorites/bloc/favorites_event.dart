part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoad extends FavoritesEvent {
  final List<dynamic> ids;
  const FavoritesLoad({
    required this.ids,
  });


  @override
  List<Object> get props => [ids];
}
