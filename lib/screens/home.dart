import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import '../models/user.dart';

class Home extends StatelessWidget {
  Home({super.key});

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void logout(BuildContext context) {
    SessionManager().remove("user");
    Navigator.of(context).pop();
  }

  late Future<User> user = getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Auth Demo"),
          actions: [
            Tooltip(
              message: "Log Out",
              child: IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: const Icon(Icons.logout)),
            )
          ],
        ),
        body: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String username = snapshot.data!.username;
              return Column(
                children: [
                  Text("Welcome, $username!",
                      style: const TextStyle(fontSize: 30)),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Text("Loading");
          },
        ));
  }
}
