
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/models/data_response.dart';


enum FavoritesStatus { init, loading, loaded, error }

// ignore: must_be_immutable
class FavoritesState extends Equatable {
  List<dynamic>? favorites;
  DataResponse? data;
  FavoritesStatus? status;
  FavoritesState(
    this.favorites,
    this.data,
    this.status,
  );

  FavoritesState.init()
      : this([], DataResponse([], "init"), FavoritesStatus.init);
  FavoritesState.loading()
      : this([], DataResponse([], "loading"), FavoritesStatus.loading);
    FavoritesState.loaded( List<dynamic>favorites,DataResponse data)
      : this(favorites, data, FavoritesStatus.loaded);
      FavoritesState.error(DataResponse data)
      : this([], data, FavoritesStatus.error);
  @override
  List<Object> get props => [favorites!, data!, status!];

  FavoritesState copyWith({
    List<dynamic>? favorites,
    DataResponse? data,
    FavoritesStatus? status,
  }) {
    return FavoritesState(
      favorites ?? this.favorites,
      data ?? this.data,
      status ?? this.status,
    );
  }
}
