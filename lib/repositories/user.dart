import 'dart:convert';
import 'package:checklist/model/user.dart';
import 'package:checklist/repositories/repository.dart';

class UserRepository {
  Repository repository;
  UserRepository(this.repository);

  Future<String?> login(String username, String password) async {
    try {
      print(username);
      print(password);
      final response =
          await repository.http?.post(url: 'auth/login', bodyParameters: {
        'username': username,
        'password': password,
      });

      final data = json.decode(response!.body);

      if (response.statusCode == 200) {
        final token = data['access_token'];

        repository.sessionRepository?.setToken(token);

        return token;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<UserModel> me() async {
    try {
      final response = await repository.http!.post(url: 'auth/me');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        repository.sessionRepository!.setUser(
          username: data['username'].toString(),
          fullname: data['name'].toString() + ' ' + data['lastname'].toString(),
        );
        return UserModel.fromData(data);
      } else {
        return await repository.sessionRepository!.getUser();
      }
    } catch (error) {
      return await repository.sessionRepository!.getUser();
    }
  }

  // Future chart() async {
  //   try {
  //     final response = await repository.http!.get(url: 'odl/history');
  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       return data['odls'];
  //     }
  //   } catch (error) {
  //     return [];
  //   }
  // }

  Future<String> refresh() async {
    final response = await repository.http!.post(url: 'auth/refresh');
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      final token = data['access_token'];
      print(token);

      repository.sessionRepository!.setToken(token);

      return token;
    }

    throw RequestError(response.statusCode);
  }
}
