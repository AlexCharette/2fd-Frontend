part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = FormzStatus.pure,
    this.email = const Username.pure(),
  });

  final FormzStatus status;
  final Username email;

  ResetPasswordState copyWith({Username email, FormzStatus status}) {
    return ResetPasswordState(
        email: email ?? this.email, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, email];
}
