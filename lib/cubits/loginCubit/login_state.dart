part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}
final class LoginIsLoadingState extends LoginState {}
final class LoginSuccessState extends LoginState {}
final class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState({required this.errorMessage});
}


