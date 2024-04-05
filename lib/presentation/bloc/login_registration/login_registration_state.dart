



part of 'login_registration_cubit.dart';

abstract class LoginRegistrationState {}

class LoginRegistrationInitial extends LoginRegistrationState {
 final bool isLogin;

  LoginRegistrationInitial({required this.isLogin});
}

class LoginRegistrationLoading extends LoginRegistrationState {}

class LoginRegistrationSuccess extends LoginRegistrationState {}

class LoginRegistrationFailure extends LoginRegistrationState {
  final String error;

  LoginRegistrationFailure(this.error);
}