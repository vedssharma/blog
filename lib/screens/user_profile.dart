import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "../widgets/user_posts_list.dart";
import "../models/user.dart";
import "./change_email.dart";
import "./change_password.dart";
import "./change_username.dart";

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  late Future<User> user = getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: user,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data as User;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome, ${user.username}!",
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Email: ${user.email}",
                      style: const TextStyle(fontSize: 20)),
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeEmail()));
                      })
                ],
              ),
              const SizedBox(height: 30),
              const Text("My Posts:"),
              UserPostsList(user: user),
              const SizedBox(height: 30),
              Container(
                  margin: const EdgeInsets.all(60),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).secondaryHeaderColor,
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text("Change password"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                      })),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeUsername()));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).secondaryHeaderColor,
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("Change Username"))
            ],
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return const Text("Loading");
      }),
    ));
  }
}
