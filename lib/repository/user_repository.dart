import 'package:capitan_test_project/models/badge_obj.dart';
import 'package:capitan_test_project/models/login_model.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepository {
  final Box<UserObj> usersBox;

  const UserRepository(this.usersBox);

  Future<List<UserObj>> getUsers() async{
    List<UserObj> users = usersBox.values.toList();
    return users;
  }

  Future<int> createUser({required LoginModel loginModel}) async{
    UserObj userObj = UserObj(username: loginModel.username, password: loginModel.password, isAdmin: loginModel.isAdmin!,badges: []);
    int value = await usersBox.add(userObj);
    userObj.id = value;
    usersBox.put(value, userObj);
    return value;
  }

  Future<void> addBadge(BadgeObj badgeObj, userId) async{
    UserObj userObj = usersBox.get(userId)!;
    userObj.badges.add(badgeObj);
    await usersBox.put(userId, userObj);
  }
}