part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInSubmit extends LogInEvent {
  final String email;
  final String password;
  const LogInSubmit({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LogInSignOut extends LogInEvent {
  const LogInSignOut();

  @override
  List<Object> get props => [];
}
