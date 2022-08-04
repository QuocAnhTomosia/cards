import 'package:equatable/equatable.dart';

import 'package:yugi_oh_cards/services/cards_api_services.dart';

enum StatusCode { init, loaded, loading, error }

class HomeState extends Equatable {
  DataResponse? data;
  StatusCode? statusCode;
  HomeState(
    this.data,
    this.statusCode,
  );
  HomeState.initState() : this(DataResponse([], "init"), StatusCode.init);
  HomeState.loadingState()
      : this(DataResponse([], "loading"), StatusCode.loading);
  HomeState.loaded(DataResponse data) : this(data, StatusCode.loaded);
  HomeState.error(DataResponse data) : this(data, StatusCode.error);
  @override
  List<Object> get props => [data!, statusCode!];
}
