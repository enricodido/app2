import 'package:checklist/model/checklist.dart';
import 'package:intl/intl.dart';

class Section {
  Section({
    required this.id,
    required this.description,
    required this.checklist,
    required this.done,
    required this.control,

  });

  final String id;
  final String description;
  final ChecklistModel checklist;
  final bool done;
  final bool control;


  factory Section.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final ChecklistModel checklist = ChecklistModel.fromData(data['checklist_model']);
    final bool done = data['done'].toString() == 'true';
    final bool control =  data['control'] ;


    return Section(
      id: id,
      description: description,
      checklist: checklist,
      done: done,
      control: control,
    );

  }
}