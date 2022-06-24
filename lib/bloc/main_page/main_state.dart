part of 'main_cubit.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class MainLoading extends MainState{
  @override
  List<Object?> get props => [];
}

class MainError extends MainState{
  final String message;

  const MainError({required this.message});
  @override
  List<Object?> get props => [];
}

class MainLoaded extends MainState{
  final List<UserObj> users;

  const MainLoaded({required this.users});

  @override
  List<Object?> get props => [];
}
