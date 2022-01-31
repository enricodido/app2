import 'dart:convert';

import 'package:checklist/model/item.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:checklist/repositories/repository.dart';

class VehicleRepository {
  late Repository repository;
  VehicleRepository(this.repository);

  Future<List<Vehicle>> get() async {
    final response = await repository.http!.get(
      url: 'vehicle/models', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Vehicle> vehicles = [];
      data['vehicles'].forEach((vehicle) {
        vehicles.add(Vehicle.fromData(vehicle));
      });
      return vehicles;
    }

    throw RequestError(data);
  }


}