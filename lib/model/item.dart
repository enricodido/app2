import 'package:intl/intl.dart';

class Item {
  Item({
    required this.id,
    required this.description,
    required this.section_id,
    required this.type,

  });

  final String id;
  final String description;
  final String section_id;
  final String type;


  factory Item.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String section_id = data['checklist_section_id'].toString();
    final String type = data['type'].toString();



    return Item(
      id: id,
      description: description,
      section_id: section_id,
      type: type,

    );

  }
}