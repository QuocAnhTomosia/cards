import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/bloc/log_in/bloc/log_in_state.dart';
import 'package:yugi_oh_cards/components/constant.dart';
import 'package:yugi_oh_cards/services/firebase_auth_service.dart';
import 'package:yugi_oh_cards/services/firebase_firestore_service.dart';

import '../../../models/user_model.dart';

part 'log_in_event.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInState.initState()) {
    on<LogInEvent>((event, emit) {});
    on<LogInSubmit>(_onSubmit);
    on<LogInChangeInfo>((event, emit) async {
      {
        FireStoreService().updateInfo(state.message!, event.field, event.data);
        MyUser user = await FireStoreService().getUserByUid(state.message!);
        emit(LogInState(
            message: state.message!,
            status: LogInStatus.success,
            myUser: user));
      }
    });
    on<LogInReset>(
      (event, emit) {
        FirebaseAuthService().signOut();
        emit(const LogInState(message: "", status: LogInStatus.init));
      },
    );
  }

  Future<void> _onSubmit(LogInSubmit event, Emitter emit) async {
    try {
      String result =
          await FirebaseAuthService().emailSignIn(event.email, event.password);
      if (result != "some error happend") {
        MyUser user = await FireStoreService().getUserByUid(result);
        emit(LogInState(
            message: result, status: LogInStatus.success, myUser: user));
      } else {
        emit(LogInState(
            message: result,
            status: LogInStatus.error,
            myUser: Constant.errorUser));
      }
    } catch (e) {
      emit(LogInState(
          message: "Please correct your email or password",
          status: LogInStatus.error,
          myUser: Constant.errorUser));
    }
  }
}
