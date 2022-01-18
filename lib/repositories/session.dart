import 'package:shared_preferences/shared_preferences.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';


class SessionRepository {
  Repository repository;
  SessionRepository(this.repository);

  String? token;
  String? fullname;
  String? username;

  Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("TOKEN");
  }

  void setToken(String token) async {
    this.token = token;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("TOKEN", token);
  }

  void setUser({required String fullname, required String username}) async {
    this.fullname = fullname;
    this.username = username;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("FULLNAME", fullname);
    preferences.setString("USERNAME", username);
  }

  Future<UserModel> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.fullname = preferences.getString("FULLNAME");
    this.username = preferences.getString("USERNAME");

    return UserModel(
      fullname: this.fullname ?? '-',
      username: this.username ?? '-',
    );
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("TOKEN");
  }

  bool isLogged() {
    return this.token != null;
  }
}
