import 'package:checklist/model/selectModel.dart';

class UserModel {
  UserModel({
    required this.lastname,
    required this.name,
    required this.email,
    required this.checklist,
  });

  final String lastname;
  final String name;
  final String email;
  final Checklist checklist;

  factory UserModel.fromData(Map<String, dynamic> data) {

    final String lastname = data['lastname'].toString();
    final String name = data['name'].toString();
    final String email = data['email'].toString();
    final Checklist checklist = Checklist.fromData(data['checklist']);

    return UserModel(
        lastname: lastname,
        name: name,
        email: email,
        checklist: checklist
    );

  }
}
