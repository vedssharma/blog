import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import '../models/user.dart';
import "../models/post.dart";

// User Database operations

Future<Database> getdb() async {
  final database = openDatabase(join(await getDatabasesPath(), "users.db"),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE users(id INTEGER, email String, username String, password String)");
  }, version: 1);

  return database;
}

Future<bool> addUser(User user) async {
  Database db = await getdb();
  String email = user.email;
  String username = user.username;
  String password = user.password;
  bool exists = await userExists(email);
  if (exists == false) {
    //Insert user to users table
    db.insert(
        "users", {"email": email, "username": username, "password": password});
    return true;
  }
  return false;
}

Future<bool> userExists(String email) async {
  Database db = await getdb();
  var result = await db.query("users", where: "email = ?", whereArgs: [email]);
  return result.isNotEmpty;
}

Future<User> getUser(String email) async {
  Database db = await getdb();
  var result = await db.query("users", where: "email = ?", whereArgs: [email]);
  User user = User(
      email: result[0]["email"].toString(),
      username: result[0]["username"].toString(),
      password: result[0]["password"].toString());
  return user;
}

// Post Database operations
Future<Database> getPostdb() async {
  final database = openDatabase(join(await getDatabasesPath(), "posts.db"),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE posts(id INTEGER, title String, author String, body String)");
  }, version: 1);

  return database;
}

Future<void> addPost(Post post) async {
  Database db = await getPostdb();
  String title = post.title;
  String author = post.author;
  String body = post.body;

  db.insert("posts", {"title": title, "author": author, "body": body});
}

Future<List<Post>> getPosts() async {
  Database db = await getPostdb();
  var result = await db.query("posts");
  List<Post> posts = [];
  for (var i = 0; i < result.length; i++) {
    Post post = Post(
      title: result[i]["title"].toString(),
      author: result[i]["author"].toString(),
      body: result[i]["body"].toString(),
    );

    posts.add(post);
  }

  return posts.reversed.toList();
}

Future<List<Post>> getPostsByUser(String username) async {
  Database db = await getPostdb();
  var result =
      await db.query("posts", where: "author = ?", whereArgs: [username]);
  List<Post> userPosts = [];
  for (var i = 0; i < result.length; i++) {
    Post post = Post(
      title: result[i]["title"].toString(),
      author: username,
      body: result[i]["body"].toString(),
    );
    userPosts.add(post);
  }

  return userPosts.reversed.toList();
}
