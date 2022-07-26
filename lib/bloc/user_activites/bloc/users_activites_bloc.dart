import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/bloc/cards_searching/bloc/user_activities_bloc.dart';
import 'package:yugi_oh_cards/models/sign_up_model.dart';

part 'users_activites_event.dart';
part 'users_activites_state.dart';

class UsersActivitesBloc extends Bloc<UsersActivitesEvent, UsersActivitesState> {
  UsersActivitesBloc() : super(UsersActivitesInitial()) {
    on<UsersActivitesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
