import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "../models/user.dart";
import "../models/post.dart";
import "../data/db.dart";
import "package:auth_demo/screens/post_screen.dart";

class UserPosts extends StatelessWidget {
  UserPosts({Key? key}) : super(key: key);

  Future<User> getUser() async {
    return User.fromJson(await SessionManager().get("user"));
  }

  Future<List<Post>> getUserPosts() async {
    User user = await getUser();
    return getPostsByUser(user.username);
  }

  void delete(BuildContext context, Post post) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Post"),
            content: const Text("Are you sure you want to delete this post?"),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    //Delete post
                    deletePost(post);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  late Future<List<Post>> userPosts = getUserPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: const Text("My Posts"),
        ),
        body: FutureBuilder(
          future: userPosts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data as List<Post>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PostScreen(post: posts[index])));
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(children: [
                            Text(posts[index].title),
                            Text(posts[index].author),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  delete(context, posts[index]);
                                })
                          ]),
                        ),
                      ));
                },
                itemCount: posts.length,
              );
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Text("Loading");
          },
        ));
  }
}
