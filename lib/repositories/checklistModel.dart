import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/model/checklist.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class ChecklistModelRepository {
  late Repository repository;
  ChecklistModelRepository(this.repository);


  Future<String?> create(
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
      showCustomDialog(
        context: context,
        type: CustomDialog.INFO,
        msg: data['msg'],
      );
      return data;
    }
    throw RequestError(data);
  }


  Future<List<ChecklistModel>> get() async {
    final response = await repository.http!.get(
        url: 'get/models');
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