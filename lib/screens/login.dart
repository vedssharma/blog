import 'package:flutter/material.dart';
import '../data/db.dart';
import '../models/user.dart';
import 'home.dart';
import "package:flutter_session_manager/flutter_session_manager.dart";
import "package:auth_demo/widgets/login_form.dart";
import "dart:convert";
import "package:crypto/crypto.dart";

class Login extends StatelessWidget {
  Login({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login(BuildContext context) async {
    bool existingUser = await userExists(emailController.text);
    if (existingUser == false) {
      //Invalid: User does not exist
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "User does not exist. Try again with different credentials or create an account."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Try Again"))
              ],
            );
          });
    } else {
      //Check if password they enter matches password in db. If it does, then take user to home screen.
      // Other wise, invalid credentials popup.
      User user = await getUser(emailController.text);

      //hash password
      var bytes = utf8.encode(passwordController.text);
      var digest = sha256.convert(bytes);

      if (digest.toString() == user.password) {
        //Correct Password, go to home screen
        SessionManager().set("user", user);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      } else {
        //Incorrect password dialog popup
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Incorrect Password"),
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
        automaticallyImplyLeading: false,
        title: const Text("Auth Demo"),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: LoginForm(
        emailController: emailController,
        passwordController: passwordController,
        login: login,
      ),
    );
  }
}
