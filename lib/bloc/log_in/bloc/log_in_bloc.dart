import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yugi_oh_cards/models/user_model.dart';
import 'package:yugi_oh_cards/services/firebase_firestore_service.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<LogInEvent>((event, emit) {});
    on<LogInSubmit>((event, emit) async{
      emit(LogInInitial());
      
       try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: event.email,
                    password: event.password,
                  );
                  // ignore: use_build_context_synchronously
                
                 print( FireStoreService().getUser(event.email));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    emit(LogInError(e.code));
                  } else if (e.code == 'wrong-password') {emit(LogInError(e.code));}
                }
    });
  }
}
