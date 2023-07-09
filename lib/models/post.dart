class Post {
  final String title;
  final String author;
  final String body;
  final DateTime dateCreated;

  Post(
      {required this.title,
      required this.body,
      required this.author,
      required this.dateCreated});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> post = <String, dynamic>{};
    post["title"] = title;
    post["body"] = body;
    post["author"] = author;
    post["dateCreated"] = dateCreated;
    return post;
  }

  Post.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        author = json["author"],
        dateCreated = json["dateCreated"];
}
