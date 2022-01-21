class SelectModel {
  SelectModel({
    required this.id,
    required this.description,
    required this.status,
  });

  final String id;
  final String description;
  final String status;

  factory SelectModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    final String status = data['status'].toString();

    return SelectModel(
      id: id,
      description: description,
      status: status,
    );

  }
}
