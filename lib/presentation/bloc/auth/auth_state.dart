

part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
 // final String userId;

  Authenticated();
}

class Unauthenticated extends AuthState {}
