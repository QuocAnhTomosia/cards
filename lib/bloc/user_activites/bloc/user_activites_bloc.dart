import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_activites_event.dart';
part 'user_activites_state.dart';

class UserActivitesBloc extends Bloc<UserActivitesEvent, UserActivitesState> {
  UserActivitesBloc() : super(UserActivitesInitial()) {
    on<UserActivitesEvent>((event, emit) {});
  }
}
