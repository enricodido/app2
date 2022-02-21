import 'dart:convert';

import 'package:checklist/model/item.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/src/widgets/framework.dart';

class VehicleRepository {
  late Repository repository;
  VehicleRepository(this.repository);

  Future<List<Vehicle>> get() async {
    final response = await repository.http!.get(
      url: 'vehicle', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Vehicle> vehicles = [];
      data['vehicle'].forEach((vehicle) {
        vehicles.add(Vehicle.fromData(vehicle));
      });
      return vehicles;
    }

    throw RequestError(data);
  }

  Future<Vehicle?> getSingle( {required String checklist_id}) async {
    final response = await repository.http!.post(
      url: 'vehicle/single', bodyParameters: {
        'checklist_id': checklist_id
      });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data['vehicle'] != null ? Vehicle.fromData(data['vehicle']) : null;

    }

    throw RequestError(data);
  }

}