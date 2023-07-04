import "package:flutter/material.dart";
import "package:auth_demo/screens/create_account.dart";

class LoginForm extends StatelessWidget {
  const LoginForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.login});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function login;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
                child: const Text("Don't have an account"))
          ])
        ],
      )),
    );
  }
}
