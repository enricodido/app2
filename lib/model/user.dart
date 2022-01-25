import 'package:checklist/model/selectModel.dart';

class UserModel {
  UserModel({
    required this.lastname,
    required this.name,
    required this.email,
  });

  final String lastname;
  final String name;
  final String email;

  factory UserModel.fromData(Map<String, dynamic> data) {

    final String lastname = data['lastname'].toString();
    final String name = data['name'].toString();
    final String email = data['email'].toString();

    return UserModel(
        lastname: lastname,
        name: name,
        email: email,
    );

  }
}
