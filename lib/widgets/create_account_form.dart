import "package:flutter/material.dart";
import "package:auth_demo/screens/login.dart";

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm(
      {super.key,
      required this.emailController,
      required this.usernameController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.createAccount});

  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function createAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                label: Text("Create a username"), border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
                label: Text("Create a password"), border: OutlineInputBorder()),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(
                label: Text("Confirm password"), border: OutlineInputBorder()),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text("Already have account")),
            ],
          )
        ],
      )),
    );
  }
}
