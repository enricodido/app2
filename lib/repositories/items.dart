import 'dart:convert';

import 'package:checklist/model/item.dart';
import 'package:checklist/repositories/repository.dart';

class ItemRepository {
  late Repository repository;
  ItemRepository(this.repository);

  Future<List<Item>> get({required String section_id}) async {
    final response = await repository.http!.get(
      url: 'text/models/' + section_id, );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Item> items = [];
      data['checklist_items'].forEach((item) {
        items.add(Item.fromData(item));
      });
      return items;
    }

    throw RequestError(data);
  }

  Future<String> value(
      context,
      String value,
      ) async {

    final response = await repository.http!.post(url: 'record/models', bodyParameters: {
      'value': value,
    });

    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_item'].toString();
    }
    throw RequestError(data);
  }


}