

import 'dart:io';
import 'package:checklist/repositories/section.dart';
import 'package:checklist/repositories/session.dart';
import 'package:checklist/repositories/time.dart';
import 'package:checklist/repositories/user.dart';
import 'package:checklist/repositories/selectModel.dart';
import 'package:checklist/repositories/vehicle.dart';
import 'package:http/http.dart' as http;
import 'checklistModel.dart';
import 'items.dart';
import 'text.dart';

//const String HOST = 'https://checklist.deltacall.it/api/';
const String HOST = 'http://192.168.1.94:8080/api/';

class Repository {
  Repository() {
    http = HttpClient(this);
    userRepository = UserRepository(this);
    sessionRepository = SessionRepository(this);
    selectModelRepository = SelectModelRepository(this);
    checklistModelRepository = ChecklistModelRepository(this);
    itemRepository = ItemRepository(this);
    sectionRepository = SectionRepository(this);
    vehicleRepository = VehicleRepository(this);
    textRepository = TextRepository(this); 
  }

  HttpClient? http;
  UserRepository? userRepository;
  SessionRepository? sessionRepository;
  SelectModelRepository? selectModelRepository;
  ChecklistModelRepository? checklistModelRepository;
  ItemRepository? itemRepository;
  SectionRepository? sectionRepository;
  TimeRepository? timeRepository;
  VehicleRepository? vehicleRepository;
  TextRepository? textRepository;
}

class HttpClient {
  HttpClient(this.repository) {
    client = http.Client();
  }
  final Repository repository;
  http.Client? client;

  Map<String, String> headers() {
    if (repository.sessionRepository!.isLogged()) {
      return {"Authorization": "Bearer ${repository.sessionRepository!.token}"};
    } else {
      return {};
    }
  }

  Future<http.Response> get({
    required String url,
    Map? queryParameters,
  }) {
    return http.get(
      Uri.parse(HOST + url),
      headers: headers(),
    );
  }


  Future<http.Response> post({
    required String url,
    Map bodyParameters = const {},
  })  {
    return http.post(
      Uri.parse(HOST + url),
      body: bodyParameters,
      headers: headers(),
    );
  }

  Future<http.Response> postMultipart({
    required String url,
    Map bodyParameters = const {},
    Map<String, File> fileParameters = const {},
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(HOST + url),
    );

    request.headers.addAll(headers());

    bodyParameters.forEach((key, value) {
      request.fields[key] = value;
    });

    fileParameters.forEach((key, file) async {
      var requestFile = await http.MultipartFile.fromPath(key, file.path);
      request.files.add(requestFile);
    });

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}

class RequestError {
  final error;
  RequestError(this.error);
}
