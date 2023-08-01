import "package:flutter/material.dart";
import "package:auth_demo/data/db.dart";
import "package:auth_demo/models/user.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "dart:convert";
import "package:crypto/crypto.dart";

class ChangePassword extends StatelessWidget {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  Future<void> changePassword() async {
    User user = await getUser();
    var bytes = utf8.encode(currentPasswordController.text);
    var digest = sha256.convert(bytes);
    if (digest.toString() == user.password) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        var newBytes = utf8.encode(newPasswordController.text);
        var newDigest = sha256.convert(newBytes);
        await updatePassword(user, newDigest.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change password"),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
          child: Form(
              child: Column(children: [
        TextFormField(
          obscureText: true,
          controller: currentPasswordController,
          decoration: const InputDecoration(
              labelText: "Current Password",
              hintText: "Enter current password"),
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          controller: newPasswordController,
          decoration: const InputDecoration(
              labelText: "New Password", hintText: "Enter new password"),
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          controller: confirmNewPasswordController,
          decoration: const InputDecoration(
              labelText: "Confirm New Password",
              hintText: "Confirm new password"),
        ),
        ElevatedButton(
          onPressed: () {
            changePassword();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Updated password"),
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
