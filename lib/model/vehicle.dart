import 'package:intl/intl.dart';

class Vehicle {
  Vehicle({
    required this.id,
    required this.description,
    

  });

  final String id;
  final String description;


  factory Vehicle.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();


    return Vehicle(
      id: id,
      description: description,

    );

  }
}