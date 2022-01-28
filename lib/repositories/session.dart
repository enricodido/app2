import 'package:checklist/repositories/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SessionRepository {
  Repository repository;
  SessionRepository(this.repository);

  String? token;

  Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.token = preferences.getString("TOKEN");
  }

  void setToken(String token) async {
    this.token = token;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("TOKEN", token);
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("TOKEN");
  }

  bool isLogged() {
    return this.token != null;
  }

}
