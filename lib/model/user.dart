import 'package:checklist/model/selectModel.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.lastname,
    required this.name,
    required this.email,
    required this.medic,
    required this.driver,
  });

  final String id;
  final String lastname;
  final String name;
  final String email;
  final String medic;
  final String driver;


  factory UserModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String lastname = data['lastname'].toString();
    final String name = data['name'].toString();
    final String email = data['email'].toString();
    final String driver = data['driver'].toString();
    final String medic = data['medic'].toString();


    return UserModel(
        id: id,
        lastname: lastname,
        name: name,
        email: email,
        driver: driver,
        medic: medic,
    );

  }
}
