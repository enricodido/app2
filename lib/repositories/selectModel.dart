import 'dart:convert';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class SelectModelRepository {
  late Repository repository;
  SelectModelRepository(this.repository);

  Future<List<SelectModel>> get({required String status}) async {
    final response = await repository.http!.post(
        url: 'get/list_models', bodyParameters: {
      'status': status,
    });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<SelectModel> models = [];
      data['models'].forEach((model) {
        models.add(SelectModel.fromData(model));
      });
      return models;
    }

    throw RequestError(data);
  }
}