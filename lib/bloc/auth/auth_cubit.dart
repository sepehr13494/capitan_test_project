import 'package:bloc/bloc.dart';
import 'package:capitan_test_project/models/login_model.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository = UserRepository();
  AuthCubit() : super(AuthInitial());

  login(LoginModel loginModel) async {
    emit(AuthLoading());
    List<UserObj> users = await _userRepository.getUsers();
    for (var element in users) {
      if(element.username == loginModel.username){
        if(element.password == loginModel.password){
          Hive.box("auth").put("userId",element.id);
          Hive.box("auth").put("admin",element.isAdmin);
          emit(const AuthSuccess(message: "Login Successful"));
          return;
        }
      }
    }
    emit(const AuthLoginError(message: "Login Failed"));
  }

  register(LoginModel loginModel) async {
    emit(AuthLoading());

    List<UserObj> users = await _userRepository.getUsers();
    for (var element in users) {
      if(element.username == loginModel.username){
        emit(const AuthRegisterError(message: "Already exist"));
        return;
      }
    }
    int value = await _userRepository.createUser(loginModel: loginModel);
    Hive.box("auth").put("userId",value);
    Hive.box("auth").put("admin",loginModel.isAdmin);
    emit(const AuthSuccess(message: "Registered Successfully"));
  }
}
