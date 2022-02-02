import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/model/checklist.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class ChecklistModelRepository {
  late Repository repository;
  ChecklistModelRepository(this.repository);

  Future<bool?> close(
      context,
      String user_id,
      String date,
      ) async {
    final response = await repository.http!.post(url: 'checklist/close', bodyParameters: {
      'user_id': user_id,
      'done' : date
    });
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



  Future<List<ChecklistModel>> get({required String user_id}) async {
    final response = await repository.http!.get(
        url: 'get/models/'+ user_id, );
    print('get/models/'+ user_id);
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