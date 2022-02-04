

import 'package:intl/intl.dart';

class ChecklistModel {
  ChecklistModel({
    required this.id,
    required this.model,
    required this.user_id,
    required this.vehicle_id, 
    required this.created_at
  });

  final String id;
  final String model;
  final String user_id;
  final String vehicle_id;
  final String created_at;


  factory ChecklistModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String model = data['model'].toString();
    final String user_id = data['user_id'].toString();
    final String vehicle_id =  data['vehicle_type_id'].toString() ;
    String created_at = '';
    if(data['created_at'].toString().substring(0,16).contains('T')) {
      created_at = DateFormat('dd-MM-yyy HH:mm').format(DateFormat('yyyy-MM-ddTHH:mm').parse(data['created_at'].toString().substring(0,16)).add(Duration(hours: 1)));
    } else {
      created_at = DateFormat('HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['created_at'].toString().substring(0,16)));
    }


    return ChecklistModel(
      id: id,
      model: model,
      user_id: user_id,
      vehicle_id: vehicle_id,
      created_at: created_at
    );

  }
}
