import 'package:intl/intl.dart';

class Item {
  Item({
    required this.id,
    required this.description,

  });

  final String id;
  final String description;


  factory Item.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();


    return Item(
      id: id,
      description: description,

    );

  }
}