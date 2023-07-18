import "package:flutter/material.dart";
import "package:auth_demo/data/db.dart";
import "package:auth_demo/models/post.dart";
import "package:auth_demo/screens/post_screen.dart";

class AllPosts extends StatelessWidget {
  AllPosts({Key? key}) : super(key: key);

  late Future<List<Post>> posts = getPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: posts,
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
      ),
    );
  }
}
