import 'dart:convert';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';

class SelectModelRepository {
  late Repository repository;
  SelectModelRepository(this.repository);

  Future<List<SelectModel>> get() async {
    final response = await repository.http!.get(
        url: 'get/list_models', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<SelectModel> models = [];
      data['list_models'].forEach((model) {
        models.add(SelectModel.fromData(model));
      });
      return models;
    }

    throw RequestError(data);
  }
}