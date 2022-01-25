import 'package:checklist/model/selectModel.dart';

class UserModel {
  UserModel({
    required this.lastname,
    required this.name,
    required this.email,
    required this.model,
  });

  final String lastname;
  final String name;
  final String email;
  final selectModel model;

  factory UserModel.fromData(Map<String, dynamic> data) {

    final String lastname = data['lastname'].toString();
    final String name = data['name'].toString();
    final String email = data['email'].toString();
    final selectModel model = selectModel.fromData(data['model']);

    return UserModel(
        lastname: lastname,
        name: name,
        email: email,
        model: model
    );

  }
}
