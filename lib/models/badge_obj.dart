import 'package:hive_flutter/hive_flutter.dart';

part 'badge_obj.g.dart';

@HiveType(typeId: 1)
class BadgeObj {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final String name;

  BadgeObj({
    required this.userId,
    required this.name,
  });
}
