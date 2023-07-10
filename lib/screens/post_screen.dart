import "package:flutter/material.dart";
import "package:auth_demo/models/post.dart";

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text("Post"),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(post.author),
          const SizedBox(height: 10),
          Text(post.body),
        ],
      )),
    );
  }
}
