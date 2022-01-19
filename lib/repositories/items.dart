import 'dart:convert';

import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class ItemRepository {
  late Repository repository;
  ItemRepository(this.repository);

  Future<List> getItems({
    required String id,
    required String description,
    required String checklistType,
    required String type,
    required String checklistSectionId,
    bool? value,
    bool? working,
    required BuildContext context,
  }) async {
    try {
      final response = await repository.http!.get(url: 'text/models');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['text/models'];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

}