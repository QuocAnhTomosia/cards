import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/services/firebase_firestore_service.dart';

part 'user_sign_up_event.dart';
part 'user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  UserSignUpBloc() : super(UserSignUpState.init()) {
    on<UserSignUpEvent>((event, emit) {});
    on<UserSignUpStart>((event, emit) {
      emit(UserSignUpState.init());
    });
    on<UserSignUpSubmit>((event, emit) async {
      if (event.reEnter != event.password) {
        emit(UserSignUpState.error(
            "your password and reEnter password are not the same"));
        return;
      }
      if (event.password.length < 6) {
        emit(UserSignUpState.error("your password it's too short"));
      }
      try {
        String img =
            await FireStoreService().uploadImage(File(event.image.path));
        String status = await FireStoreService().addNewUser(
            event.name, event.email, event.password, img, event.phoneNumber);
        if (status == "Success") {
          emit(UserSignUpState.submit());
        } else {
          emit(UserSignUpState.error(status));
        }
      } catch (e) {
        emit(UserSignUpState.error(e.toString()));
      }
    });
  }
}
