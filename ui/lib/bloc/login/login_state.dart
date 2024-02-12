part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Username username;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  LoginState copyWith({
    Username? username,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => [username, password];
}
