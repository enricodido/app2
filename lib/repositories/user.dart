import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';


class UserRepository {
  Repository repository;
  UserRepository(this.repository);

  Future<String?> login(context, String username, String password) async {
    final response = await repository.http!.post(url: 'auth/login', bodyParameters: {
      'username': username,
      'password': password,
    });
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      final token = data['access_token'];
      repository.sessionRepository!.setToken(token);
      return token;
    }

    throw RequestError(data['error']);

  }

  Future<UserModel> me() async {
    final response = await repository.http!.post(url: 'auth/me');
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return UserModel.fromData(data);
    }

    throw RequestError(data);
  }

  Future<String> refresh() async {
    final response = await repository.http!.post(url: 'auth/refresh');
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      final token = data['access_token'];
      repository.sessionRepository!.setToken(token);
      return token;
    }

    throw RequestError(data);
  }

}
