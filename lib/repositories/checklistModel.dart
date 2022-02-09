import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/model/checklist.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class ChecklistModelRepository {
  late Repository repository;
  ChecklistModelRepository(this.repository);

  Future<String?> close(
      context, String checklist_id,
      ) async {
    final response = await repository.http!.post(url: 'close/models', bodyParameters: {
      'checklist_id': checklist_id,
    });
     final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_id'].toString();
    }
    throw RequestError(data);
  }

 Future<String?> vehicle(
      context, String checklist_id, String vehicle_id
      ) async {
    final response = await repository.http!.post(url: 'store/vehicle', bodyParameters: {
      'checklist_id': checklist_id,
      'vehicle_type_id': vehicle_id,
    });
     final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_id'].toString();
    }
    throw RequestError(data);
  }

  Future<String> create(
      context,
      String user_id,
      String model_id,
      ) async {

    final response = await repository.http!.post(url: 'store/models', bodyParameters: {
      'user_id': user_id,
      'model_id': model_id,

    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_id'].toString();
    }
    throw RequestError(data);
  }

Future<String?> signature(
      context, String checklist_id, String signature
      ) async {
    final response = await repository.http!.post(url: 'signature', bodyParameters: {
      'checklist_id': checklist_id,
      'signature': signature,
    });
     final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_id'].toString();
    }
    throw RequestError(data);
  }

  Future<List<ChecklistModel>> get() async {
    final response = await repository.http!.get(
        url: 'get/models' );
    print('get/models');
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<ChecklistModel> checklists = [];
      data['checklist_models'].forEach((checklist) {
        checklists.add(ChecklistModel.fromData(checklist));
      });
      return checklists;
    }

    throw RequestError(data);
  }
}