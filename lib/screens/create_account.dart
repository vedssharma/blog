import 'package:flutter/material.dart';
import 'login.dart';
import '../models/user.dart';
import '../models/db.dart';
import 'home.dart';
import "package:flutter_session_manager/flutter_session_manager.dart";
import "package:auth_demo/validate.dart";
import "package:google_fonts/google_fonts.dart";

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void createAccount(BuildContext context) async {
    //Validate email format
    validateEmail(emailController.text, context);
    validatePassword(
        passwordController.text, confirmPasswordController.text, context);

    User user = User(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text);

    bool newUser = await addUser(user);
    if (!newUser) {
      //User with that email exists dialog
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("A user with that email exists"),
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
      SessionManager().set("user", user);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Auth Demo",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 100),
        child: Form(
            child: Column(
          children: [
            const Text(
              "Create an Account",
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
              controller: usernameController,
              decoration: const InputDecoration(
                  label: Text("Create a username"),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  label: Text("Create a password"),
                  border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                  label: Text("Confirm password"),
                  border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      createAccount(context);
                    },
                    child: const Text("Create Account")),
                TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text("Already have account"))
              ],
            )
          ],
        )),
      ),
    );
  }
}
