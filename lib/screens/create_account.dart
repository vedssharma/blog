import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/db.dart';
import 'home.dart';
import "package:flutter_session_manager/flutter_session_manager.dart";
import "package:auth_demo/validate.dart";
import "package:google_fonts/google_fonts.dart";
import "package:auth_demo/widgets/create_account_form.dart";
import "dart:convert";
import "package:crypto/crypto.dart";

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

    //Hash password
    var bytes = utf8.encode(passwordController.text);
    var digest = sha256.convert(bytes);

    User user = User(
        email: emailController.text,
        username: usernameController.text,
        password: digest.toString());

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Auth Demo",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: CreateAccountForm(
          emailController: emailController,
          usernameController: usernameController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          createAccount: createAccount),
    );
  }
}
