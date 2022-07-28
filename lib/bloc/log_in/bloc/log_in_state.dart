part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();
  
  @override
  List<Object> get props => [];
}

class LogInInitial extends LogInState {}


class LogInError extends LogInState
{
  final String error;
  const LogInError(this.error);
}

class LogInSuccess extends LogInState
{
  final MyUser user;
  const LogInSuccess(this.user);
   @override
  List<Object> get props => [user];
}