import 'package:equatable/equatable.dart';

enum LogInStatus { init, error, success }

class LogInState extends Equatable {
  final LogInStatus? status;
  final String? message;
  const LogInState({
    this.status,
    this.message,
  });
  const LogInState.initState() : this(status: LogInStatus.init);
  LogInState copyWith({
    
    String? message,
    LogInStatus? logInStatus,
  }) {
    return LogInState(
      message: message,
      status: logInStatus,
    );
  }

  const LogInState.error( String mess) : this(message: mess,status: LogInStatus.error);
  const LogInState.success(String uid) : this(message: uid,status: LogInStatus.success);

  @override
  List<Object?> get props => [ message,status];
}
