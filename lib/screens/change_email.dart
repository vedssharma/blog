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

  Future<void> changeEmail(BuildContext context) async {
    User user = await getUser();
    if (newEmailController.text == confirmNewEmailController.text) {
      await updateEmail(user, newEmailController.text);
    } else {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Emails do not match"),
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
          title: const Text("Change Email"),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  controller: newEmailController,
                  decoration: const InputDecoration(
                      labelText: "New Email",
                      hintText: "Enter new email",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmNewEmailController,
                  decoration: const InputDecoration(
                      labelText: "Confirm New Email",
                      hintText: "Confirm new email",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    changeEmail(context);
                    logout(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Updated email. Log in again to see changes."),
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
