part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final String error;

  AuthFailureState({required this.error});
}

class PasswordHidden extends AuthState {}

class PasswordVisible extends AuthState {}
