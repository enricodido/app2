import 'dart:convert';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class SelectModelRepository {
  late Repository repository;
  SelectModelRepository(this.repository);

  Future<List<selectModel>> get({required String description}) async {
    final response = await repository.http!.post(
        url: 'get/list_models', bodyParameters: {
      'description': description,
    });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<selectModel> models = [];
      data['models'].forEach((model) {
        models.add(selectModel.fromData(model));
      });
      return models;
    }

    throw RequestError(data);
  }
}