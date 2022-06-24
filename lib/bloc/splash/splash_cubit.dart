import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Box authBox;
  SplashCubit(this.authBox) : super(SplashInitial());

  checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    var userId = authBox.get("userId",defaultValue: null);
    if(userId == null){
      emit(SplashLoggedOut());
    }else{
      emit(SplashLoggedIn());
    }
  }
}
