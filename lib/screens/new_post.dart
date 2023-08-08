import "package:flutter/material.dart";
import "package:auth_demo/models/post.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import '../models/user.dart';
import "../data/db.dart";

class NewPost extends StatefulWidget {
  NewPost({Key? key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  _NewPostState({Key? key});

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void post() async {
    String authorUsername = (await getUser()).username;
    Post post = Post(
      title: titleController.text,
      body: bodyController.text,
      author: authorUsername,
    );
    await addPost(post);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                labelText: "Title", hintText: "Enter title"),
            controller: titleController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
                labelText: "Body", hintText: "Enter body"),
            maxLines: null,
            controller: bodyController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              post();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Posted"),
              ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text("Post"),
          )
        ],
      )),
    ));
  }
}
