import 'package:flutter/material.dart';
import 'create_account.dart';
import '../models/db.dart';
import '../models/user.dart';
import 'home.dart';
import "package:flutter_session_manager/flutter_session_manager.dart";

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
      if (passwordController.text == user.password) {
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
        title: const Text("Auth Demo"),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 100),
        child: Form(
            child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  label: Text("Email"), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  label: Text("Password"), border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    login(context);
                  },
                  child: const Text("Login")),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateAccount()));
                  },
                  child: const Text("Don't have an account"))
            ])
          ],
        )),
      ),
    );
  }
}
