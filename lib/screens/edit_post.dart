import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "package:auth_demo/models/user.dart";
import "package:auth_demo/models/post.dart";
import "../data/db.dart";

class EditPost extends StatelessWidget {
  EditPost({Key? key, required this.oldPost}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  final Post oldPost;

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  void edit() async {
    String user = (await getUser()).username;
    String title = titleController.text;
    String body = bodyController.text;

    Post updatedPost = Post(title: title, body: body, author: user);

    await updatePost(oldPost, updatedPost);
  }

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
                onPressed: () {
                  edit();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text("Update"),
              )
            ],
          )),
        ));
  }
}
