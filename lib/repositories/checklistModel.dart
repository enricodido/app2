import 'dart:convert';
import 'package:checklist/components/customDialog.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter/cupertino.dart';

class ChecklistModelRepository {
  late Repository repository;
  ChecklistModelRepository(this.repository);

  Future<bool> createChecklistModel({
    required String id,
    required String model,
    // AGGIUNGERE UTENTE
    required BuildContext context,
  }) async {
    try {
      final response =
      await repository.http!.post(url: 'store/models', bodyParameters: {
        'id': id,
        'model': model,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        showCustomDialog(
            context: context,
            type: CustomDialog.ERROR,
            msg: 'Attenzione!\n' +
                (jsonDecode(response.body)['msg'] ??
                    'Errore.\n non eseguito!')
                    .toString());
        return false;
      }
    } catch (error) {
      print(error);
      showCustomDialog(
        context: context,
        type: CustomDialog.ERROR,
        msg: 'Attenzione!\nErrore.',
      );
      return false;
    }
  }
  Future<List> getChecklistModel({
    required String id,
    required String model,
    String? vehicleType,
    String? status,
    String? done,
    required BuildContext context,
  }) async {
    try {
      final response = await repository.http!.get(url: 'models');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return data['models'];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

}