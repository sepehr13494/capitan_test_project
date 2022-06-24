import 'package:capitan_test_project/bloc/auth/auth_cubit.dart';
import 'package:capitan_test_project/global_functions.dart';
import 'package:capitan_test_project/models/login_model.dart';
import 'package:capitan_test_project/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final bool register =
        (ModalRoute.of(context)!.settings.arguments ?? false) as bool;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state){
            if(state is AuthError){
              GlobalFunctions.showSnackBar(context, state.message);
            }else if (state is AuthSuccess){
              GlobalFunctions.showSnackBar(context, state.message,color: Colors.green);
              Navigator.pushReplacementNamed(context, Routes.main);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                register ? CheckboxListTile(
                    value: value,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Register as admin"),
                    onChanged: (val) {
                      setState(() {
                        value = val!;
                      });
                    }) : Container(),
                ElevatedButton(
                    onPressed: state is AuthLoading ? null : () {
                      if (!register) {
                        BlocProvider.of<AuthCubit>(context).login(LoginModel(
                            username: usernameController.text,
                            password: passwordController.text));
                      } else {
                        BlocProvider.of<AuthCubit>(context).register(LoginModel(
                            username: usernameController.text,
                            password: passwordController.text,
                            isAdmin: value));
                      }
                    },
                    child: state is AuthLoading ? const Text("loading") : Text(register ? "Register" : "Login")),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.login,
                        arguments: !register);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      register ? "Login here" : "Register here",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ].map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: e,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
