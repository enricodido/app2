
import 'item.dart';

class Text {
  Text({
    required this.id,
    required this.description,
    
  });

  final String id;
  final String description;


  factory Text.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String description = data['description'].toString();
    


    return Text(
      id: id,
      description: description,
      
    );

  }
}