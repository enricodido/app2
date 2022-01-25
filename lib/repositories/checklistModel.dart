import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/model/checklist.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class ChecklistModelRepository {
  late Repository repository;
  ChecklistModelRepository(this.repository);


  Future<bool> insert(
      context,
      String user_id,
      String checklist_id,
      String vehicleId,
      String done,
      String model
      ) async {

    final response = await repository.http!.post(url: 'record/models', bodyParameters: {
      'user_id': user_id,
      'checklist_id': checklist_id,
      'vehicleId': vehicleId,
      'done': done,
      'model': model,

    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      showCustomDialog(
        context: context,
        type: CustomDialog.INFO,
        msg: data['msg'],
      );
      return true;
    } else {
      showCustomDialog(
        context: context,
        type: CustomDialog.ERROR,
        msg: 'Errore!',
      );
      return false;
    }
    throw RequestError(data);
  }


  Future<List<ChecklistModel>> get() async {
    final response = await repository.http!.post(
        url: 'get/models', bodyParameters: {
    });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<ChecklistModel> checklists = [];
      data['checklists'].forEach((checklist) {
        checklists.add(ChecklistModel.fromData(checklist));
      });
      return checklists;
    }

    throw RequestError(data);
  }
}