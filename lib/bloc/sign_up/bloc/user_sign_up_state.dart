part of 'user_sign_up_bloc.dart';

enum SignUpStatus { init, submit, error }

// ignore: must_be_immutable
class UserSignUpState extends Equatable {
  String error;
  SignUpStatus status;
  UserSignUpState({
    required this.error,
    required this.status,
  });

  @override
  List<Object> get props => [error, status];

  UserSignUpState.init() : this(error: "init", status: SignUpStatus.init);
  UserSignUpState.submit() : this(error: "no", status: SignUpStatus.submit);
  UserSignUpState.error(String error)
      : this(error: error, status: SignUpStatus.error);
}
