import 'package:bloc/bloc.dart';
import 'package:capitan_test_project/main.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:capitan_test_project/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final UserRepository _userRepository = UserRepository();
  MainCubit() : super(MainInitial());

  getUsers() async {
    List<UserObj> users = await _userRepository.getUsers();
    emit(MainLoaded(users: users));
  }
  
  logout(){
    Hive.box("auth").clear();
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.context, Routes.splash, (route) => false);
  }
}
