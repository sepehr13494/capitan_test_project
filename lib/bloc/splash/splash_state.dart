part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoggedIn extends SplashState{
  @override
  List<Object?> get props => [];
}
class SplashLoggedOut extends SplashState{
  @override
  List<Object?> get props => [];
}
