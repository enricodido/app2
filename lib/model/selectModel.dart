import 'package:intl/intl.dart';

class selectModel {
  selectModel({
    required this.id,
    required this.done,
    required this.description,
    required this.status,
  });

  final String id;
  final String done;
  final String description;
  List<selectModel> status;

  factory selectModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String done = DateFormat('dd/MM/yyyy HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['date'].toString()));
    final String description = data['description'].toString();
    final String status = data['status'].toString();

    return selectModel(
      id: id,
      done: done,
      description: description,
      status: [],
    );

  }
}
