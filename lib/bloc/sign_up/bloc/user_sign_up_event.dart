part of 'user_sign_up_bloc.dart';

abstract class UserSignUpEvent extends Equatable {
  const UserSignUpEvent();

  @override
  List<Object> get props => [];
}

class UserSignUpStart extends UserSignUpEvent {
  const UserSignUpStart();
  @override
  List<Object> get props => [];
}

class UserSignUpSubmit extends UserSignUpEvent {
  final SignUpInfo info;
  const UserSignUpSubmit({
    required this.info,
  });
  @override
  List<Object> get props => [info];
}
