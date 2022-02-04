

import 'dart:convert';

import 'package:checklist/repositories/repository.dart';

import '../model/text.dart';

class TextRepository {
  late Repository repository;

  TextRepository(this.repository);

  Future<List<Text>> get({required String item_id}) async {
    final response = await repository.http!.get(
      url: 'get/list/' + item_id,);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Text> lists = [];
      data['checklist_texts'].forEach((list) {
        lists.add(Text.fromData(list));
      });
      return lists;
    }

    throw RequestError(data);
  }
}
