import 'dart:convert';

import 'package:checklist/model/time.dart';
import 'package:checklist/repositories/repository.dart';


class TimeRepository {
  Repository repository;
  TimeRepository(this.repository);

  Future<List<TimeModel>> get({required String date}) async {
    final response = await repository.http!.post(url: 'time/slot', bodyParameters: {
      'date': date
    });
    final data = json.decode(response.body);
    
    if (response.statusCode == 200) {
        List<TimeModel> slots = [];
        data['slots'].forEach((key, element) {
            slots.add(TimeModel.fromData(key.toString(), element.toString()));
        });
        return slots;
    }

    throw RequestError(data);
  }

}
