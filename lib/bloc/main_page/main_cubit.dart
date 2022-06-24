import 'package:bloc/bloc.dart';
import 'package:capitan_test_project/global_functions.dart';
import 'package:capitan_test_project/main.dart';
import 'package:capitan_test_project/models/badge_obj.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:capitan_test_project/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final UserRepository userRepository;
  final Box authBox;
  MainCubit(this.userRepository, this.authBox) : super(MainInitial());

  getUsers() async {
    emit(MainLoading());
    List<UserObj> users = await userRepository.getUsers();
    emit(MainLoaded(users: users,isAdmin: authBox.get("admin",defaultValue: false)));
  }
  
  logout(){
    authBox.clear();
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.context, Routes.splash, (route) => false);
  }

  addBadge(String badge, UserObj userObj) async {
    EasyLoading.show();
    int thisUserId = authBox.get("userId");
    BadgeObj badgeObj = BadgeObj(userId: thisUserId,name: badge);
    for (var element in userObj.badges) {
      if(element.userId == thisUserId){
        EasyLoading.dismiss();
        GlobalFunctions.showSnackBar(navigatorKey.currentState!.context, "Already added");
        return;
      }
    }
    await userRepository.addBadge(badgeObj, userObj.id);
    EasyLoading.dismiss();
    getUsers();
    GlobalFunctions.showSnackBar(navigatorKey.currentState!.context, "Badge added Successfully",color: Colors.green);
  }
}
