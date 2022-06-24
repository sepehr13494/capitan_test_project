import 'package:capitan_test_project/bloc/splash/splash_cubit.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (BuildContext context) => SplashCubit()..checkLogin(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoggedIn) {
              Navigator.pushReplacementNamed(context, Routes.main);
            } else if (state is SplashLoggedOut) {
              Navigator.pushReplacementNamed(context, Routes.login);
            }
          },
          child: const Center(
            child: Text("Capitan"),
          ),
        ),
      ),
    );
  }
}

