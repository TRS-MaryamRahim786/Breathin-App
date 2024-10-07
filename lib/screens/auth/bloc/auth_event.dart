part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSubmittedEvent extends AuthEvent {
  final UserModel user;
  BuildContext context;
  bool isTermsAndConditionAccepted;
  AuthSubmittedEvent({
    required this.user,
    required this.context,
    required this.isTermsAndConditionAccepted,
  });
}
