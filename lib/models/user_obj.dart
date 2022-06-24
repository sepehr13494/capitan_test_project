import 'package:hive_flutter/hive_flutter.dart';

part 'user_obj.g.dart';

@HiveType(typeId: 0)
class UserObj extends HiveObject {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  bool isAdmin;

  UserObj( {this.id, required this.username, required this.password, required this.isAdmin});
}