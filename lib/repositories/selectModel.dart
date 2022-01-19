import 'dart:convert';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class SelectModelRepository {
  late Repository repository;
  SelectModelRepository(this.repository);

  Future<List> getModel({
    required String id,
    required String description,
    required String companyId,
    required bool driver,
    required bool medic,
    required bool status,
    required BuildContext context,
  }) async {
    try {
      final response = await repository.http!.get(url: 'list_models');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['list_models'];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

}