import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "../data/db.dart";
import "../models/user.dart";
import "package:auth_demo/screens/login.dart";

class ChangeEmail extends StatelessWidget {
  ChangeEmail({Key? key}) : super(key: key);

  TextEditingController newEmailController = TextEditingController();
  TextEditingController confirmNewEmailController = TextEditingController();

  void logout(BuildContext context) {
    SessionManager().remove("user");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  Future<void> changeEmail() async {
    User user = await getUser();
    if (newEmailController.text == confirmNewEmailController.text) {
      await updateEmail(user, newEmailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Change Email"),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: Container(
            child: Form(
                child: Column(
          children: [
            TextFormField(
              controller: newEmailController,
              decoration: const InputDecoration(
                  labelText: "New Email", hintText: "Enter new email"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmNewEmailController,
              decoration: const InputDecoration(
                  labelText: "Confirm New Email",
                  hintText: "Confirm new email"),
            ),
            ElevatedButton(
              onPressed: () {
                changeEmail();
                logout(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Updated email. Log in again to see changes."),
                ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text("Change Email"),
            )
          ],
        ))));
  }
}
