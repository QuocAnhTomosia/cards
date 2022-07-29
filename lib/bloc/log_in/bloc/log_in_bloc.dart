import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yugi_oh_cards/bloc/log_in/bloc/log_in_state.dart';
import 'package:yugi_oh_cards/services/firebase_auth_service.dart';

part 'log_in_event.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(const LogInState.initState()) {
    on<LogInEvent>((event, emit) {});
    on<LogInSubmit>(_onSubmit);
    on<LogInReset>(
      (event, emit) {
        emit(const LogInState(message: "", status: LogInStatus.init));
      },
    );
  }

  Future<void> _onSubmit(LogInSubmit event, Emitter emit) async {
    try {
      String result =
          await FirebaseAuthService().emailSignIn(event.email, event.password);
      emit(LogInState(message: result, status: LogInStatus.success));
    } catch (e) {
      emit(LogInState(message: e.toString(), status: LogInStatus.error));
    }
  }
}
