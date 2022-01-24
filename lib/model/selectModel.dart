import 'package:intl/intl.dart';

class Checklist {
  Checklist({
    required this.id,
    required this.done,
    required this.description,
    required this.status,
  });

  final String id;
  final String done;
  final String description;
  List<Checklist> status;

  factory Checklist.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String done = DateFormat('dd/MM/yyyy HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['date'].toString()));
    final String description = data['description'].toString();
    final String status = data['status'].toString();

    return Checklist(
      id: id,
      done: done,
      description: description,
      status: [],
    );

  }
}
