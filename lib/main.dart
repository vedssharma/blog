import 'package:flutter/material.dart';
import 'screens/create_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Auth App",
      home: const Home(),
      theme: ThemeData(
          primaryColor: Colors.black, secondaryHeaderColor: Colors.white),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccount();
  }
}
