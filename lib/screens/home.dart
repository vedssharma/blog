import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import '../models/user.dart';
import "package:auth_demo/screens/all_posts.dart";
import "package:auth_demo/screens/new_post.dart";
import "package:auth_demo/screens/user_posts.dart";

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
          automaticallyImplyLeading: false,
          title: const Text("Auth Demo"),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
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
              return Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text("Welcome, $username!",
                        style: const TextStyle(fontSize: 30)),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllPosts()));
                        },
                        child: const Text("All Posts")),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => UserPosts()),
                          );
                        },
                        child: const Text("My Posts")),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewPost()));
                        },
                        child: const Text("New Post")),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Text("Loading");
          },
        ));
  }
}
