part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInChangeEmail extends LogInEvent {
  final String email;
  const LogInChangeEmail({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class LogInChangePassword extends LogInEvent {
  final String password;
  const LogInChangePassword({
    required this.password,
  });
  @override
  List<Object> get props => [password];
}

class LogInReset extends LogInEvent {
  const LogInReset();
  @override
  List<Object> get props => [];
}

class LogInSubmit extends LogInEvent {
  final String email;
  final String password;
  const LogInSubmit({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}
