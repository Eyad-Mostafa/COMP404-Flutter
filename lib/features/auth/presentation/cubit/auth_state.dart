
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessMessage extends AuthState {
  final String message;
  AuthSuccessMessage(this.message);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}