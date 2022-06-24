import 'package:capitan_test_project/bloc/main_page/main_cubit.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit()..getUsers(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Main Page"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    BlocProvider.of<MainCubit>(context).logout();
                  },
                )
              ],
            ),
            body: state is MainLoaded
                ? Builder(builder: (context) {
                    List<UserObj> users = state.users;
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          UserObj user = users[index];
                          return ListTile(
                            title: Text(user.username),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () {
                                addBadge(context);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, _) => const Divider(),
                        itemCount: users.length);
                  })
                : const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
          );
        },
      ),
    );
  }

  void addBadge(context) {
    List<String> badges = [
      "Batman",
      "SpiderMan",
      "Sniper",
    ];
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text(badges[index])),
                        );
                      },
                      separatorBuilder: (context, _) => Divider(),
                      itemCount: badges.length),
                ),
              ],
            ),
          );
        });
  }
}
