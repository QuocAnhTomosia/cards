import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeSubmit extends HomeEvent {
  final String language;
  const HomeSubmit({required this.language});

  @override
  List<Object> get props => [language];
}
