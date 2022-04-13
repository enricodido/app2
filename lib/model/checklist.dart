import 'package:checklist/model/user.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:intl/intl.dart';

class ChecklistModel {
  ChecklistModel({
    required this.id,
    required this.model,
    required this.user,
    required this.vehicle_name,

    required this.created_at,
    required this.signature,
// this.vehicle
  });

  final String id;
  final String model;
 
  final String created_at;
  final String signature;
  final String? vehicle_name;
  final UserModel user;


  factory ChecklistModel.fromData(Map<String, dynamic> data) {

    final String id = data['id'].toString();
    final String model = data['model'].toString();
    final String signature = data['signature'].toString();
    final String? vehicle_name = data['vehicle_id'] != null?  (data['vehicle']['model'].toString() + data['vehicle']['license_plate'].toString() ) : 'Non selezionato' ;
    
    String created_at = '';
    if(data['created_at'].toString().substring(0,16).contains('T')) {
      created_at = DateFormat('dd-MM-yyy HH:mm').format(DateFormat('yyyy-MM-ddTHH:mm').parse(data['created_at'].toString().substring(0,16)).add(Duration(hours: 1)));
    } else {
      created_at = DateFormat('HH:mm').format(DateFormat('yyyy-MM-dd HH:mm').parse(data['created_at'].toString().substring(0,16)));
    }
    final UserModel user = UserModel.fromData(data['user']);

    return ChecklistModel(
      id: id,
      model: model,
      user: user,
      vehicle_name: vehicle_name,
     
      created_at: created_at,
      signature: signature
    );

  }
}
