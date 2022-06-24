import 'package:capitan_test_project/models/login_model.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepository {

  Future<List<UserObj>> getUsers() async{
    Box<UserObj> usersBox = await Hive.openBox("users");
    return usersBox.values.toList();
  }

  Future<int> createUser({required LoginModel loginModel}) async{
    Box<UserObj> usersBox = await Hive.openBox("users");
    UserObj userObj = UserObj(username: loginModel.username, password: loginModel.password, isAdmin: loginModel.isAdmin!);
    int value = await usersBox.add(userObj);
    userObj.id = value;
    usersBox.put(value, userObj);
    return value;
  }
}