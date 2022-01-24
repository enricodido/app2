import 'dart:convert';
import 'dart:core';
import 'dart:core';
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
  Future<String?> getChecklistModel(String id, String model, String vehicleType, String status, String done) async {
    try {
      final response =
      await repository.http!.post(url: 'getmodel', bodyParameters: {
        'id': id,
        'model': model,
        'vehicleType': vehicleType,
        'status': status,
        'done': done,
      });

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final token = data['access_token'];

        repository.sessionRepository!.setToken(token);

        return token;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}