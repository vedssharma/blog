import "package:flutter/material.dart";
import "package:auth_demo/models/user.dart";
import "package:auth_demo/data/db.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "package:auth_demo/screens/login.dart";

class ChangeUsername extends StatelessWidget {
  ChangeUsername({Key? key}) : super(key: key);

  TextEditingController newUsernameController = TextEditingController();
  TextEditingController confirmNewUsernameController = TextEditingController();

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void logout(BuildContext context) {
    SessionManager().remove("user");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> changeUsername(BuildContext context) async {
    User user = await getUser();
    if (newUsernameController.text == confirmNewUsernameController.text) {
      await updateUsername(user, newUsernameController.text);
    } else {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Usernames do not match"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Try Again"))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Change Username"),
          elevation: 0,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: newUsernameController,
                decoration: const InputDecoration(
                    labelText: "New Username",
                    hintText: "Enter new username",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: confirmNewUsernameController,
                decoration: const InputDecoration(
                    labelText: "Confirm New Username",
                    hintText: "Confirm new username",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  changeUsername(context);
                  logout(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("Updated username. Log in again to see changes."),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text("Change Username"),
              )
            ],
          )),
        ));
  }
}
