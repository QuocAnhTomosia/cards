import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_activities_event.dart';
part 'user_activities_state.dart';

class UserActivitiesBloc extends Bloc<UserActivitiesEvent, UserActivitiesState> {
  UserActivitiesBloc() : super(UserActivitiesInitial()) {
    on<UserActivitiesEvent>((event, emit) {
  
    });
  }
}
