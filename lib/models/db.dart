import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'user.dart';

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
