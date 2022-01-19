import 'dart:convert';

import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class SectionRepository {
  late Repository repository;
  SectionRepository(this.repository);

  Future<List> getSections({
    required String id,
    required String description,
    required String checklistModelId,
    required BuildContext context,
  }) async {
    try {
      final response = await repository.http!.get(url: 'section/models');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['section/models'];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

}