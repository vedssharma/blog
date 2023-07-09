import "package:flutter/material.dart";
import "package:auth_demo/models/post.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import '../models/user.dart';
import "../data/db.dart";

class NewPost extends StatelessWidget {
  NewPost({Key? key}) : super(key: key);

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void post() async {
    String authorUsername = (await getUser()).username;
    Post post = Post(
        title: titleController.text,
        body: bodyController.text,
        author: authorUsername,
        dateCreated: DateTime.now());
    await addPost(post);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: const Text("New Post"),
        ),
        body: Container(
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
              ElevatedButton(
                onPressed: post,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text("Post"),
              )
            ],
          )),
        ));
  }
}
