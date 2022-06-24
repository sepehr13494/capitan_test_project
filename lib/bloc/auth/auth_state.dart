part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState{
  @override
  List<Object?> get props => [];
}

abstract class AuthError extends AuthState{
  final String message;
  const AuthError({required this.message});
}
class AuthLoginError extends AuthError{
  const AuthLoginError({required super.message});

  @override
  List<Object?> get props => [];
}
class AuthRegisterError extends AuthError{
  const AuthRegisterError({required super.message});

  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState{
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object?> get props => [];
}
