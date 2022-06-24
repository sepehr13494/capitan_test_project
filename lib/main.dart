import 'package:capitan_test_project/bloc/auth/auth_cubit.dart';
import 'package:capitan_test_project/models/badge_obj.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:capitan_test_project/navigation/pages.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:capitan_test_project/injection_container.dart' as di;

import 'injection_container.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserObjAdapter());
  Hive.registerAdapter(BadgeObjAdapter());
  await di.init();
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
          create: (BuildContext context) => AuthCubit(sl(),sl()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Captian',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: appRoutes(context),
        initialRoute: Routes.splash,
        builder: EasyLoading.init(),
      ),
    );
  }
}
