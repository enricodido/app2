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

  Future<String> value(context,
      String value, String working, String item_id
      ) async {

    final response = await repository.http!.post(url: 'record/models', bodyParameters: {
      
      'item_id': item_id,
      'value': value,
      'working': working,
    });
    print(item_id);
    print(value);
    print(working);
    final data = json.decode(response.body);
    if (response.statusCode == 200) {

      return data['checklist_item'].toString();
    }
    throw RequestError(data);
  }

Future<bool> check({required String section_id}) async {
    final response = await repository.http!.get(
      url: 'get/check/' + section_id, );
    final data = json.decode(response.body);

     if (response.statusCode == 200) {

      return true;
    } else {

      return false;
    }

    throw RequestError(data);
  }

}