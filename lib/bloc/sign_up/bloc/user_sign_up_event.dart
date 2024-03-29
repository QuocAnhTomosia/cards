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
  final String name;
  final String email;
  final String password;
  final File image;
  final String phoneNumber;
  final String reEnter;
  const UserSignUpSubmit({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.phoneNumber,
    required this.reEnter,
  });
  @override
  List<Object> get props => [name, email, password, image, phoneNumber];
}
