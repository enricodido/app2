import 'package:checklist/model/checklist.dart';
import 'package:intl/intl.dart';

class Section {
  Section({
    required this.id,
    required this.description,
    required this.checklist_id,
    required this.done,
    required this.control,

  });

  final String id;
  final String description;
  final String checklist_id;
  final bool done;
  final bool control;


  factory Section.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String checklist_id = data['checklist_model_id'].toString();
    final bool done = data['done'].toString() == 'true';
    final bool control = data['control'];


    return Section(
      id: id,
      description: description,
      checklist_id: checklist_id,
      done: done,
      control: control,
    );

  }
}