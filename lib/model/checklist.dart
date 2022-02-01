

class ChecklistModel {
  ChecklistModel({
    required this.id,
    required this.model,
    required this.user_id,
  });

  final String id;
  final String model;
  final String user_id;


  factory ChecklistModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String model = data['model'].toString();
    final String user_id = data['user_id'].toString();


    return ChecklistModel(
      id: id,
      model: model,
      user_id: user_id,
    );

  }
}
