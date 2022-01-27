import 'dart:convert';

import 'package:checklist/model/section.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class SectionRepository {
  late Repository repository;
  SectionRepository(this.repository);

  Future<List<Section>> get({required String checklist_id}) async {
    final response = await repository.http!.get(
      url: 'section/models', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Section> sections = [];
      data['checklist_sections'].forEach((section) {
        sections.add(Section.fromData(section));
      });
      return sections;
    }

    throw RequestError(data);
  }


}