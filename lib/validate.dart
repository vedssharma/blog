import "package:flutter/material.dart";
import "package:email_validator/email_validator.dart";

void validateEmail(String email, BuildContext context) {
  bool emailValid = EmailValidator.validate(email);
  if (emailValid == false) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Email entered is invalid."),
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

void validatePassword(
    String password1, String password2, BuildContext context) {
  if (password1 != password2) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Passwords don't match"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Try Again"))
            ],
          );
        });
  } else if (password1.length < 8) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Password too short"),
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
