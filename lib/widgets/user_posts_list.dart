import "package:flutter/material.dart";
import "package:flutter_session_manager/flutter_session_manager.dart";
import "../models/post.dart";
import "../models/user.dart";
import "../data/db.dart";
import "../screens/post_screen.dart";
import "../screens/edit_post.dart";
import "../screens/home.dart";

class UserPostsList extends StatelessWidget {
  UserPostsList({Key? key, required this.user}) : super(key: key);

  final User user;

  Future<List<Post>> getUserPosts() async {
    return getPostsByUser(user.username);
  }

  late Future<List<Post>> userPosts = getUserPosts();

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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Post deleted"),
                      duration: Duration(seconds: 2),
                    ));
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

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userPosts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data as List<Post>;
          if (posts.isEmpty) {
            return const Text("No posts to show");
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PostScreen(post: posts[index])));
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Text(posts[index].title),
                        Text(posts[index].author),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditPost(oldPost: posts[index])));
                            }),
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
    );
  }
}
