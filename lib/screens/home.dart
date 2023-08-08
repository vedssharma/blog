import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import '../models/user.dart';
import "package:auth_demo/screens/all_posts.dart";
import "package:auth_demo/screens/new_post.dart";
import "package:auth_demo/screens/user_profile.dart";

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void logout(BuildContext context) {
    SessionManager().remove("user");
    Navigator.of(context).pop();
  }

  late Future<User> user = getUser();

  int currentIndex = 0;
  String currentTitle = "My Profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(currentTitle),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            Tooltip(
              message: "Log Out",
              child: IconButton(
                  onPressed: () {
                    logout(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("You have been logged out."),
                    ));
                  },
                  icon: const Icon(Icons.logout)),
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
              if (currentIndex == 0) {
                currentTitle = "My Profile";
              } else if (currentIndex == 1) {
                currentTitle = "New Post";
              } else if (currentIndex == 2) {
                currentTitle = "All Posts";
              }
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person),
              label: "Me",
            ),
            NavigationDestination(icon: Icon(Icons.add), label: "New Post"),
            NavigationDestination(icon: Icon(Icons.list), label: "All Posts"),
          ],
        ),
        body: [
          UserProfile(),
          NewPost(),
          AllPosts(),
        ][currentIndex]);
  }
}
