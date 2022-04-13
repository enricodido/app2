import 'package:intl/intl.dart';

class Vehicle {
  Vehicle({
    required this.id,
    required this.license_plate,
    required this.model,

    

  });

  final String id;
  final String license_plate;
    final String model;



  factory Vehicle.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String model = data['model'].toString();
    final String license_plate = data['license_plate'].toString();


    return Vehicle(
      id: id,
      license_plate: license_plate,
      model: model,

    );

  }
}