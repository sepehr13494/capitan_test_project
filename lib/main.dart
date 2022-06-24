import 'package:capitan_test_project/bloc/auth/auth_cubit.dart';
import 'package:capitan_test_project/bloc/main_page/main_cubit.dart';
import 'package:capitan_test_project/bloc/splash/splash_cubit.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/navigation/pages.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:capitan_test_project/repository/user_repository.dart';
import 'package:capitan_test_project/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserObjAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => UserRepository(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Captian',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: appRoutes(context),
          initialRoute: Routes.splash,
        ),
      ),
    );
  }
}
