import "package:flutter/material.dart";
import "package:auth_demo/models/user.dart";
import "package:auth_demo/data/db.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";

class ChangeUsername extends StatelessWidget {
  ChangeUsername({Key? key}) : super(key: key);

  TextEditingController newUsernameController = TextEditingController();
  TextEditingController confirmNewUsernameController = TextEditingController();

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  Future<void> changeUsername() async {
    User user = await getUser();
    if (newUsernameController.text == confirmNewUsernameController.text) {
      await updateUsername(user, newUsernameController.text);
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
        body: Form(
            child: Column(
          children: [
            TextFormField(
              controller: newUsernameController,
              decoration: const InputDecoration(
                  labelText: "New Username", hintText: "Enter new username"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmNewUsernameController,
              decoration: const InputDecoration(
                  labelText: "Confirm New Username",
                  hintText: "Confirm new username"),
            ),
            ElevatedButton(
              onPressed: () {
                changeUsername();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Updated username"),
                ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text("Change Username"),
            )
          ],
        )));
  }
}
