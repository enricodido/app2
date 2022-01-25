import 'package:intl/intl.dart';

class SelectModel {
  SelectModel({
    required this.id,
    required this.done,
    required this.description,
    required this.status,
  });

  final String id;
  final String done;
  final String description;
  final String status;

  factory SelectModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String done = DateFormat('dd/MM/yyyy HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['date'].toString()));
    final String description = data['description'].toString();
    final String status = data['status'].toString();

    return SelectModel(
      id: id,
      done: done,
      description: description,
      status: status,
    );

  }
}
