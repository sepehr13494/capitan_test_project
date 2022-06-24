import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/repository/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> init() async{

  //repository
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));

  await initExternal();
}

Future<void> initExternal() async {
  final Box<UserObj> userBox = await Hive.openBox("users");
  sl.registerLazySingleton<Box<UserObj>>(() => userBox);

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);
}