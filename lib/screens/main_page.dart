import 'package:capitan_test_project/bloc/main_page/main_cubit.dart';
import 'package:capitan_test_project/injection_container.dart';
import 'package:capitan_test_project/models/user_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) =>
      MainCubit(sl(),sl())
        ..getUsers(),
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
            body: Builder(
              builder: (context) {
                if(state is MainLoaded){
                  List<UserObj> users = state.users;
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        UserObj user = users[index];
                        return ListTile(
                          title: Text(user.username),
                          subtitle: state.isAdmin ? Text(createBadgesText(user)) : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              addBadge(context, user,(badgeIndex){
                                BlocProvider.of<MainCubit>(context).addBadge(badges[badgeIndex], user);
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, _) => const Divider(),
                      itemCount: users.length);
                }else if(state is MainLoading){
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }else{
                  return const Center(child: Text("Something went wrong"),);
                }
              }
            ),
          );
        },
      ),
    );
  }

  void addBadge(BuildContext context, UserObj userObj,Function function) {
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
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            function(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(child: Text(badges[index])),
                          ),
                        );
                      },
                      separatorBuilder: (context, _) => const Divider(),
                      itemCount: badges.length),
                ),
              ],
            ),
          );
        });
  }

  String createBadgesText(UserObj user) {
    List<BadgeCountModel> badgeModels = List.generate(badges.length, (index) => BadgeCountModel(badgeName: badges[index]));
    for (BadgeCountModel badgeModel in badgeModels) {
      for (var element in user.badges) {
        if (element.name == badgeModel.badgeName) {
          badgeModel.count++;
        }
      }
    }
    return badgeModels.join("  ,  ");
  }
}

class BadgeCountModel {
  int count;
  final String badgeName;

  BadgeCountModel({this.count = 0, required this.badgeName,});

  @override
  String toString() {
    return "$badgeName ($count)";
  }

}

List<String> badges = [
  "Batman/girl",
  "Spiderman/girl",
  "Sherlock",
  "Joker",
  "Ironman/girl",
];
