import 'package:intl/intl.dart';

class Item {
  Item({
    required this.id,
    required this.description,
    required this.section_id,

  });

  final String id;
  final String description;
  final String section_id;


  factory Item.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String section_id = data['checklist_section_id'].toString();



    return Item(
      id: id,
      description: description,
      section_id: section_id,

    );

  }
}