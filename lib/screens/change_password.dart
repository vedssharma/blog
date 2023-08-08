import "package:flutter/material.dart";
import "package:auth_demo/data/db.dart";
import "package:auth_demo/models/user.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "dart:convert";
import "package:crypto/crypto.dart";
import "package:auth_demo/screens/login.dart";

class ChangePassword extends StatelessWidget {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void logout(BuildContext context) {
    SessionManager().remove("user");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> changePassword(BuildContext context) async {
    User user = await getUser();
    var bytes = utf8.encode(currentPasswordController.text);
    var digest = sha256.convert(bytes);
    if (digest.toString() == user.password) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        var newBytes = utf8.encode(newPasswordController.text);
        var newDigest = sha256.convert(newBytes);
        await updatePassword(user, newDigest.toString());
      } else {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Passwords do not match"),
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
    } else {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Password is incorrect"),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Change password"),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: Column(children: [
            TextFormField(
              obscureText: true,
              controller: currentPasswordController,
              decoration: const InputDecoration(
                  labelText: "Current Password",
                  hintText: "Enter current password",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: newPasswordController,
              decoration: const InputDecoration(
                  labelText: "New Password",
                  hintText: "Enter new password",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),
            TextFormField(
              obscureText: true,
              controller: confirmNewPasswordController,
              decoration: const InputDecoration(
                  labelText: "Confirm New Password",
                  hintText: "Confirm new password",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                changePassword(context);
                logout(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Updated password. Log in again to see changes."),
                ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text("Change Password"),
            )
          ]))),
    );
  }
}
