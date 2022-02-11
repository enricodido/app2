import 'package:checklist/model/user.dart';
import 'package:intl/intl.dart';

class ChecklistModel {
  ChecklistModel({
    required this.id,
    required this.model,
    required this.user,
    required this.vehicle_id, 
    required this.created_at,
    required this.signature,
// this.vehicle
  });

  final String id;
  final String model;
  
  final String? vehicle_id;
  final String created_at;
  final String signature;
  final UserModel user;
 // final Vehicle vehicle;


  factory ChecklistModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String model = data['model'].toString();
    final String signature = data['signature'].toString();
    final String? vehicle_id = data['vehicle_type_id'] != null?  data['vehicle_types']['id'].toString() : null ;
    String created_at = '';
    if(data['created_at'].toString().substring(0,16).contains('T')) {
      created_at = DateFormat('dd-MM-yyy HH:mm').format(DateFormat('yyyy-MM-ddTHH:mm').parse(data['created_at'].toString().substring(0,16)).add(Duration(hours: 1)));
    } else {
      created_at = DateFormat('HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['created_at'].toString().substring(0,16)));
    }
    final UserModel user = UserModel.fromData(data['user']);
 // final Vehicle vehicle = Vehicle.fromData(data['vehicle']);

    return ChecklistModel(
      id: id,
      model: model,
      user: user,
      vehicle_id: vehicle_id,
      created_at: created_at,
      signature: signature
    //  vehicle: vehicle
    );

  }
}
